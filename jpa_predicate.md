# JPA 조건조회

## Specification
```java
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository; 

@Repository
public interface PostRepository extends 
        PagingAndSortingRepository<Post, Long>, JpaSpecificationExecutor<Member>{ }
```
- Specification (title로 Post검색)
```java
public class PostSpecs {
    public static Specification<Post> withTitle(String title) {
        return (Specification<Post>) ((root, query, builder) -> 
                builder.equal(root.get("title"), title)
        );
    }
}
```
- 컨트롤러
```java
@RestController
public class PostController {

    private final PostRepository postRepository;

    public PostController(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    @GetMapping("/post/list")
    public List<Post> getPostList(@RequestParam(required = false) String title,
                                  @RequestParam(required = false) String tag,
                                  @RequestParam(required = false) Integer likes) {
        if (title != null) {
            return postRepository.findAll(PostSpecs.withTitle(title));
        } else if (...) {
            ...
        }
    }

}
```
