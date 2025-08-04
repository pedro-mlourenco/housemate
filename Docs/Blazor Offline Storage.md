# Offline Data Storage in a Blazor PWA

This guide walks you through enabling offline data storage in a Blazor Progressive Web App (PWA) by leveraging browser-based storage (IndexedDB and localStorage) and service workers.

---

## 1. Choosing the Right Storage Mechanism

- **IndexedDB**
  - A low‑level API for storing large amounts of structured data, including files and blobs.
  - Supports transactions and is suitable for complex data scenarios.

- **localStorage**
  - Simplest key‑value storage mechanism.
  - Ideal for small amounts of data (e.g., user preferences).

> **Recommendation:** Use **IndexedDB** for robust offline capabilities due to its flexibility and capacity.

---

## 2. Implementing IndexedDB in Blazor

To integrate IndexedDB into a Blazor WebAssembly project, you can use the `Blazor.IndexedDB.Framework` library.

### 2.1. Install the NuGet Package

```bash
dotnet add package Blazor.IndexedDB.Framework
```

### 2.2. Configure the Database Schema

Create a class inheriting from `IndexedDb`, defining your stores as `IndexedSet<T>` properties.

```csharp
public class MyAppDb : IndexedDb
{
    public MyAppDb(IJSRuntime jsRuntime, string name, int version)
        : base(jsRuntime, name, version)
    {
    }

    public IndexedSet<Note> Notes { get; set; }
}
```

- Here, `Note` is your data model representing the stored entities.

### 2.3. Register the IndexedDB Service

In `Program.cs`, register your database context as a scoped service:

```csharp
builder.Services.AddScoped<MyAppDb>(sp =>
    new MyAppDb(
        sp.GetRequiredService<IJSRuntime>(),
        "MyDatabase",
        1
    )
);
```

### 2.4. Performing CRUD Operations

Inject `MyAppDb` into your components or services and use the `AddAsync`, `GetAllAsync`, `UpdateAsync`, `DeleteAsync` methods:

```csharp
// Adding a new note
await db.Notes.AddAsync(new Note {
    Title = "Sample",
    Content = "This is a sample note."
});

// Reading all notes
var allNotes = await db.Notes.ToListAsync();

// Updating a note
note.Content = "Updated content.";
await db.Notes.UpdateAsync(note);

// Deleting a note
await db.Notes.DeleteAsync(note.Id);
```

---

## 3. Synchronizing with the Server

To keep client and server data in sync:

1. **Track Offline Changes**
   - Maintain a local log of operations performed while offline.

2. **Detect Network Status**
   - Use the browser's `navigator.onLine` property, and listen for `online` and `offline` events:
     ```javascript
     window.addEventListener('online',  () => { /* Trigger sync */ });
     window.addEventListener('offline', () => { /* Update UI */ });
     ```

3. **Sync Data on Reconnection**
   - When the `online` event fires, send logged changes to the server and fetch any updates to apply locally.

4. **Conflict Resolution**
   - Define strategies (e.g., last-write-wins, merge dialogs) for handling conflicting updates.

---

## 4. Leveraging Service Workers for Asset Caching

Service workers cache static assets so your PWA loads even when offline.

### 4.1. Register the Service Worker

In your `wwwroot/index.html`:

```html
<script>
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('service-worker.js');
  }
</script>
```

### 4.2. Define Caching Strategies in `service-worker.js`

```javascript
const CACHE_NAME = 'my-pwa-cache-v1';
const ASSETS = [
  '/',
  'index.html',
  'css/app.css',
  'js/app.js',
  // Add other assets
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(ASSETS))
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(cached => cached || fetch(event.request))
  );
});
```

- **`install` event**: Pre‑caches essential assets.
- **`fetch` event**: Serves cached assets when offline, falls back to network when online.

---
## Video Tutorial
- https://www.youtube.com/watch?v=xuaF7U3oziA

## Conclusion

By combining **IndexedDB** for structured offline data storage and **service workers** for asset caching, your Blazor PWA can provide a seamless offline experience. Implement robust synchronization logic to ensure data consistency when the network is restored.

