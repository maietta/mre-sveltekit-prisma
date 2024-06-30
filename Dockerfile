ARG BUN_VERSION=1.1.17
FROM oven/bun:${BUN_VERSION} AS builder

# Let's attempt to install NodeJS to get the Prisma Client to work. This was suggested in an issue filed on Github.
RUN apt update && \
    apt-get install -y nodejs --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

WORKDIR /app

ENV NODE_ENV=production

COPY --link bun.lockb package.json ./
RUN bun install

# Generate Prisma Client
COPY --link prisma .
RUN np prisma generate

# Copy application code
COPY --link . .

# Build application
RUN bun run build

# Remove development dependencies
RUN rm -rf node_modules && bun install --ci

FROM oven/bun:${BUN_VERSION} 
COPY --from=builder /app .

# Install curl for the healthcheck
RUN apt update && \
    apt-get install -y curl --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

ENV PORT=3000
EXPOSE 3000/tcp
USER bun

HEALTHCHECK --interval=5s --timeout=5s --start-period=5s --retries=3 CMD curl --fail http://localhost:3000/healthcheck

CMD ["bun", "build/index.js"]
