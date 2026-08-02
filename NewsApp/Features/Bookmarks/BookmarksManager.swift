import Foundation
import Combine
import CoreData

class BookmarkManager: ObservableObject {
    static let shared = BookmarkManager(context: PersistenceController.shared.container.viewContext)

    @Published var bookmarkedArticles: [Article] = []

    private var context: NSManagedObjectContext

    init(context:NSManagedObjectContext) {
        self.context = context
        load()
    }

    // MARK: - Toggle
    func toggleBookmark(article: Article) {
        if isBookmarked(article: article) {
            remove(article: article)
        } else {
            add(article: article)
        }
    }

    // MARK: - Check
    func isBookmarked(article: Article) -> Bool {
        bookmarkedArticles.contains(where: { $0.url == article.url })
    }

    // MARK: - Private Helpers
    private func add(article: Article) {
        ///context.insertedObjects.insert(entity) // context grabs a strong reference when we use below first line
        let entity = ArticleEntity(context: context)
        entity.url         = article.url
        entity.author      = article.author
        entity.title       = article.title
        entity.desc        = article.articleDescription
        entity.urlToImage  = article.urlToImage
        entity.publishedAt = article.publishedAt
        entity.source      = article.source.name

        save()
        load()
    }

    private func remove(article: Article) {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", article.url)

        if let results = try? context.fetch(request) {
            results.forEach { context.delete($0) }
            save()
            load()
        }
    }

    // MARK: - Core Data Save & Load
    private func save() {
        /// checking any pending unsaved changes is there or not
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Core Data save error: \(error)")
        }
    }

    private func load() {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "publishedAt", ascending: false)]

        do {
            let results = try context.fetch(request)
            bookmarkedArticles = results.map { entity in
                Article(
                    source: Source(id: nil, name: entity.source ?? ""),
                    author: entity.author ?? "",
                    title: entity.title ?? "",
                    articleDescription: entity.desc,
                    url: entity.url ?? "",
                    urlToImage: entity.urlToImage,
                    publishedAt: entity.publishedAt ?? Date(),
                    content: entity.content ?? ""
                )
            }
        } catch {
            print("Core Data fetch error: \(error)")
        }
    }
}

//@NSManaged     → saves your data TO Core Data (write)
//NSFetchRequest → gets your data FROM Core Data (read)
