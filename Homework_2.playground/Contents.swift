class Stack {
    private let linkedList = LinkedList()
    
    func push(element: Int) {
        linkedList.append(element)
    }
    
    func pop() -> Int? {
        return linkedList.removeFirst()
    }
    
    func top() -> Int? {
        return linkedList.first
    }
}

class LinkedList {
    private var head: Frame?
    var first: Int? {
        return head?.data
    }
    
    func append(_ element: Int) {
        head = Frame(data: element, previousFrame: head)
    }
    
    func removeFirst() -> Int? {
        guard let head = head else { return nil }
        self.head = head.next
        return head.data
    }
}

class Frame {
    let data: Int
    let next: Frame?
    
    init(data: Int, previousFrame: Frame?) {
        self.data = data
        self.next = previousFrame
    }
}

let stack = Stack()

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

class StackStatistics: Stack {
    private let stackOfMinElements = Stack()
    
    override func push(element: Int) {
        super.push(element: element)
        
        guard let currentMinElement = stackOfMinElements.top(), currentMinElement < element else {
            stackOfMinElements.push(element: element)
            return
        }
        stackOfMinElements.push(element: currentMinElement)
    }
    
    override func pop() -> Int? {
        guard let element = super.pop() else { return nil }
        stackOfMinElements.pop()
        return element
    }
    
    func minimumElement() -> Int? {
        return stackOfMinElements.top()
    }
}

let stackStatistics = StackStatistics()

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
