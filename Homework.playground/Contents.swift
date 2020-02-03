import Cocoa

var str = "Hello, playground"

func mean(arr: [Int]) -> Float {
    guard !arr.isEmpty else {
        return 0
    }
    let sum = arr.reduce(0, +)
    return Float(sum) / Float(arr.count)
}

func median(arr: [Int]) -> Int {
    guard !arr.isEmpty else {
        return 0
    }
    let sortedArray = quickSort(arr: arr)
    let count = sortedArray.count
    if count.isMultiple(of: 2) {
        let rightNum = sortedArray[count/2]
        let leftNum = sortedArray[count/2 - 1]
        return (leftNum + rightNum)/2
    } else {
        return sortedArray[count/2]
    }
    
}

func mode(arr: [Int]) -> [Int] {
    var dictOfModeNumbers = [Int: Int]() // [number : mode of this number], example [1, 1 ,4] -> [1: 2, 4: 1]
    var modeNumbers = [Int]()
    var counterForModeNumbers = 1
    for el in arr {
        let mode = dictOfModeNumbers[el]
        switch mode {
        case nil:
            if counterForModeNumbers > 1 {
                dictOfModeNumbers[el] = 1
            } else {
                dictOfModeNumbers[el] = 1
                modeNumbers.append(el)
            }
        case let mode? where (mode + 1) > counterForModeNumbers:
            dictOfModeNumbers[el]! += 1
            counterForModeNumbers += 1
            modeNumbers = [el]
            
        case let mode? where (mode + 1) < counterForModeNumbers:
            dictOfModeNumbers[el]! += 1
            
        case let mode? where (mode + 1) == counterForModeNumbers:
            dictOfModeNumbers[el]! += 1
            modeNumbers.append(el)

        default:
            return []
        }
    }
    
    return modeNumbers
}

func quickSort(arr: [Int]) -> [Int] {
    guard !arr.isEmpty else { return arr}
    
    var less = [Int]()
    var greater = [Int]()
    var equal = [Int]()
    let pivot = arr[arr.count/2]
    for elem in arr {
        
        switch elem {
        case (pivot+1)...:
            greater.append(elem)
        case ..<pivot:
            less.append(elem)
        case pivot:
            equal.append(elem)
        default:
            fatalError()
        }
    }
    
    return quickSort(arr: less) + equal + quickSort(arr: greater)
    
}

let seq: [Int] = [1, 1, 2, 3, 3, 2, 3, 2]

mean(arr: seq)
median(arr: seq)
mode(arr: seq)
