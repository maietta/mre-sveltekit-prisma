# MRE for SvelteKit with Prisma

This project uses Bun, exclusively.

This project is deployed via the included Dockerfile, which can be tested locally.

See the setup.txt for the steps taken to set this up.

TODO: Link to the prior and existing Github issues relating to MRE.

Attempting to build the image locally is not possible, because it appears the Prisma Client postinstall is failing. I am only able to trigger these errors to show when I add nodejs to the Dockerfile. If I do not include nodejs in the Bun base image, then there are no errors, but the app will not work still.

```text
nick@fedora:~/Projects/mre-sveltekit-prisma$ docker build .
[+] Building 5.2s (9/16)                                                                                                                                docker:default
 => [internal] load build definition from Dockerfile                                                                                                              0.0s
 => => transferring dockerfile: 1.09kB                                                                                                                            0.0s
 => [internal] load metadata for docker.io/oven/bun:1.1.17                                                                                                        1.0s
 => [internal] load .dockerignore                                                                                                                                 0.0s
 => => transferring context: 2B                                                                                                                                   0.0s
 => [builder  1/10] FROM docker.io/oven/bun:1.1.17@sha256:7b5c05b562efbbec704df426a9eef18f3b935bdc868678895a935bf120bda062                                        0.0s
 => [internal] load build context                                                                                                                                 0.3s
 => => transferring context: 49.60MB                                                                                                                              0.3s
 => CACHED [builder  2/10] RUN apt update &&     apt-get install -y nodejs --no-install-recommends &&     rm -rf /var/lib/apt/lists/* &&     apt-get clean        0.0s
 => CACHED [builder  3/10] WORKDIR /app                                                                                                                           0.0s
 => CACHED [builder  4/10] COPY --link bun.lockb package.json ./                                                                                                  0.0s
 => ERROR [builder  5/10] RUN bun install                                                                                                                         3.9s
------                                                                                                                                                                 
 > [builder  5/10] RUN bun install:                                                                                                                                    
0.173 bun install v1.1.17 (bb66bba1)                                                                                                                                   
0.175 Resolving dependencies                                                                                                                                           
1.548 Resolved, downloaded and extracted [2]                                                                                                                           
2.767 /app/node_modules/@prisma/client/scripts/postinstall.js:233                                                                                                      
2.767       const { js, ts } = defaultFiles[file] ?? {}
2.767                                              ^
2.767 
2.767 SyntaxError: Unexpected token '?'
2.767     at wrapSafe (internal/modules/cjs/loader.js:915:16)
2.767     at Module._compile (internal/modules/cjs/loader.js:963:27)
2.767     at Object.Module._extensions..js (internal/modules/cjs/loader.js:1027:10)
2.767     at Module.load (internal/modules/cjs/loader.js:863:32)
2.767     at Function.Module._load (internal/modules/cjs/loader.js:708:14)
2.767     at Function.executeUserEntryPoint [as runMain] (internal/modules/run_main.js:60:12)
2.767     at internal/main/run_main_module.js:17:47
2.768 
2.768 error: postinstall script from "@prisma/client" exited with 1
------
Dockerfile:15
--------------------
  13 |     
  14 |     COPY --link bun.lockb package.json ./
  15 | >>> RUN bun install
  16 |     
  17 |     # Generate Prisma Client
--------------------
ERROR: failed to solve: process "/bin/sh -c bun install" did not complete successfully: exit code: 1
```