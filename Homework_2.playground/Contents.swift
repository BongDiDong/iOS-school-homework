/// Container for elements organized with LIFO principle.
class Stack<Element> {
    private let linkedList = LinkedList<Element>()
    
    /// Adds a new element on top of the stack
    ///
    ///     let stack = Stack<Int>
    ///     stack.push(element: 7)
    ///     //top -> 7
    ///
    /// - Parameter element: The element to push on top of the stack
    /// - Complexity: O(1).
    func push(element: Element) {
        linkedList.append(element)
    }
    
    /// Removes and returns the first element on top of the stack
    ///
    ///     let stack = Stack<Int>()
    ///     stack.push(element: 7)
    ///     stack.push(element: 9)
    ///     //top -> 9 -> 7
    ///     print(stack.pop())
    ///     //prints "9"
    ///     //top -> 7
    ///
    /// - Returns: The first element on top of the stack, or nil if stack is empty
    /// - Complexity: O(1)
    func pop() -> Element? {
        return linkedList.removeFirst()
    }
    
    /// Returns the first element on top of the stack
    ///
    ///     let stack = Stack<Int>()
    ///     stack.push(element: 7)
    ///     stack.push(element: 9)
    ///     print(stack.top())
    ///     //prints "9"
    ///     //top -> 9 -> 7
    ///
    /// - Returns: The first element on top of the stack, or nil if stack is empty
    /// - Complexity: O(1)
    func top() -> Element? {
        return linkedList.first
    }
}

/// Linear collection of data elements, where each element points to the next element.
class LinkedList<Element> {
    private var head: Frame<Element>?
    
    /// Returns the first element in the list, or nil if list is empty
    var first: Element? {
        return head?.data
    }
    
    /// Adds a new element at the top of the list.
    ///
    ///     let linkedList = LinkedList<Int>()
    ///     linkedList.append(7)
    ///     linkedList.append(5)
    ///     //head -> 5 -> 7
    ///
    /// Property `first` now returns a new element.
    ///
    ///     print(linkedList.first)
    ///     //prints "5"
    ///
    /// - Parameter element: The element to append to the list
    /// - Complexity: O(1).
    func append(_ element: Element) {
        head = Frame(data: element, previousFrame: head)
    }
    
    /// Removes and returns the first element in the list
    ///
    ///     let linkedList = LinkedList<Int>()
    ///     linkedList.append(7)
    ///     linkedList.append(5)
    ///     //head -> 5 -> 7
    ///     print(linkedList.removeFirst())
    ///     //prints "5"
    ///     //head -> 7
    ///
    /// - Returns: The first element in the list, or nil if list is empty
    /// - Complexity: O(1)
    func removeFirst() -> Element? {
        guard let head = head else { return nil }
        self.head = head.next
        return head.data
    }
}

/// Container with particular type which can refer to another Frame.
///
/// There are two ways to initialize frame:
///
///     //without reference to another Frame
///     let frame = Frame<Int>(data: 4, previousFrame: nil)
///
///     //with reference to another Frame
///     let frameWithRef = Frame<Int>(data: 4, previousFrame: frame)
///
class Frame<Element> {
    /// Frame data of particular type
    let data: Element
    /// Reference to next Frame
    let next: Frame<Element>?

    init(data: Element, previousFrame: Frame<Element>?) {
        self.data = data
        self.next = previousFrame
    }
}

let stack = Stack<Int>()

stack.pop()
stack.top()
stack.push(element: 3)
stack.push(element: 2)
stack.push(element: 1)
stack.top()
stack.pop()
stack.pop()
stack.pop()
stack.pop()
stack.top()

/// Container for elements organized with LIFO principle. Stores the current minimum element in the container.
/// Elements in StackStatistics must conform to Comparable protocol
class StackStatistics<Element>: Stack<Element> where Element : Comparable {
    private let stackOfMinElements = Stack<Element>()
    
    override func push(element: Element) {
        super.push(element: element)
        
        guard let currentMinElement = stackOfMinElements.top(), currentMinElement < element else {
            stackOfMinElements.push(element: element)
            return
        }
        stackOfMinElements.push(element: currentMinElement)
    }
    
    override func pop() -> Element? {
        guard let element = super.pop() else { return nil }
        stackOfMinElements.pop()
        return element
    }
    
    /// Returns minimum element in the stack
    ///
    ///     let stack = StackStatistics<Int>()
    ///     stack.push(element: 3)
    ///     stack.push(element: 2)
    ///     stack.push(element: 5)
    ///     print(stack.minimumElement())
    ///     //prints "2"
    ///
    /// - Returns: The minimum element in the stack, or nil if stack is empty
    /// - Complexity: O(1)
    func minimumElement() -> Element? {
        return stackOfMinElements.top()
    }
}

let stackStatistics = StackStatistics<Int>()

stackStatistics.push(element: 3)
stackStatistics.push(element: 2)
stackStatistics.push(element: 1)
stackStatistics.push(element: 5)
stackStatistics.minimumElement()
stackStatistics.top()
stackStatistics.pop()
stackStatistics.minimumElement()
stackStatistics.pop()
stackStatistics.minimumElement()
stackStatistics.pop()
stackStatistics.minimumElement()
stackStatistics.pop()
stackStatistics.minimumElement()
stackStatistics.pop()
