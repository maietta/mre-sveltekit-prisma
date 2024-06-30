<script lang="ts">
     let { data } = $props();

     let users = data.users;
</script>

<h1>Welcome to SvelteKit</h1>
<p>Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation</p>

<hr />

<p>This is a demo for using SvelteKit with Prisma.</p>

<p>There are {users.length} entries in the Users table</p>

{#each users as user}
    <p>{user.name} <span class="badge">{user.email}</span></p>
{/each}