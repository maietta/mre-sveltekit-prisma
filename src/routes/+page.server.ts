import type { PageServerLoad } from './$types';
import { prisma } from '$lib/server/prisma'; // Single source of truth for this specific db connection.

export const load = (async () => {

    const data = await prisma.user.findMany();
    return {
        users: data
    };
}) satisfies PageServerLoad;