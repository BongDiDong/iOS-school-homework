
class Stack {
    private var head: Frame? = nil
    
    func push(element: Int) {
        if let notNilHead = head {
            head = Frame(data: element, nextFrame: notNilHead)
        } else {
            head = Frame(data: element, nextFrame: nil)
        }
    }
    
    func pop() -> Int? {
        guard let notNilHead = head else { return nil }
        head = notNilHead.next
        return notNilHead.data
    }
    
    func top() -> Int? {
        guard let notNilHead = head else { return nil }
        return notNilHead.data
    }
}

class Frame {
    let data: Int
    let next: Frame?
    
    init(data: Int, nextFrame: Frame?) {
        self.data = data
        self.next = nextFrame
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

//________________________________________________________________________

class StackStatistics: Stack {
    private let stackOfMinElements = Stack()
    
    override func push(element: Int) {
        super.push(element: element)
        
        guard let minElementInStack = stackOfMinElements.top() else {
            stackOfMinElements.push(element: element)
            return
        }
        
        if minElementInStack < element {
            stackOfMinElements.push(element: minElementInStack)
        } else {
            stackOfMinElements.push(element: element)
        }
    }
    
    override func pop() -> Int? {
        guard let number = super.pop() else { return nil }
        stackOfMinElements.pop()
        return number
    }
    
    func minimumElement() -> Int? {
        return stackOfMinElements.top()
    }
}

let stackStatistics = StackStatistics()

stackStatistics.push(element: 3)
stackStatistics.push(element: 2)
stackStatistics.push(element: 1)
stackStatistics.push(element: -1)
stackStatistics.minimumElement()
stackStatistics.pop()
stackStatistics.minimumElement()
stackStatistics.pop()
stackStatistics.minimumElement()
stackStatistics.pop()
stackStatistics.minimumElement()
stackStatistics.pop()
stackStatistics.minimumElement()
stackStatistics.pop()
