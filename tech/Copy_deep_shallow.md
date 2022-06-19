# Deep Copy 와 Shallow Copy

- `깊은 복사(Deep Copy)` : '실제 값'을 새로운 메모리 공간에 복사하는 것을 의미
- `얕은 복사(Shallow Copy` : '주소 값'을 복사한다는 의미인지
  - 얕은 복사의 경우 주소 값을 복사하기 때문에, 참조하고 있는 실제 값은 같음

얕은 복사 (Shallow Copy)

```
public class Array_Copy{
    public static void main(String[] args)  {
        int[] a = [ 1, 2, 3, 4 ];
        int[] b = a;
    }
}
```

a배열을 b배열로 = 연산자를 활용하여 대입하면, 얕은 복사가 됩니다.
b배열을 수정하면, a배열까지 같이 수정되는 상황이 됩니다.
깊은 복사 (Deep Copy)

```
Object.clone()
public class Array_Copy{
    public static void main(String[] args)  {
        int[] a = [ 1, 2, 3, 4 ];
        int[] b = a.clone();
    }
}
```

Array.clone()을 사용하면 배열을 쉽게 복사할 수 있습니다. 가장 보편적인 방법 입니다.

Arrays.copyOf()

```
import java.util.Arrays;

public class Array_Copy{
    public static void main(String[] args)  {
        int[] a = { 1, 2, 3, 4 };
        int[] b = Arrays.copyOf(a, a.length);
    }
}
```

배열의 시적점~ 원하는 length까지 배열의 깊은 복사를 할 수 있습니다.

Arrays.copyOfRange()

```

import java.util.Arrays;

public class Array_Copy{
    public static void main(String[] args)  {
        int[] a = { 1, 2, 3, 4 };
        int[] b = Arrays.copyOfRange(a, 1, 3);
    }
}
```

배열의 복사할 배열의 시작점도 지정할 수 있습니다.

System.arraycopy()

```

public class Array_Copy{
    public static void main(String[] args)  {
        int[] a = { 1, 2, 3, 4 };
        int[] b = new int[a.length];
        System.arraycopy(a, 0, b, 0, a.length);
    }
}
```

지정된 배열을 대상의 지정된 위치에 복사합니다.
