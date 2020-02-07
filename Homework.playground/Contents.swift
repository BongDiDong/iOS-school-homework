import Foundation

func mean(array: [Int]) -> Double? {
    guard !array.isEmpty else {
        return nil
    }
    let sum = array.reduce(0, +)
    return Double(sum) / Double(array.count)
}

func median(array: [Int]) -> Int? {
    guard !array.isEmpty else {
        return nil
    }
    let sortedArray = quickSort(array: array)
    let count = sortedArray.count
    if count.isMultiple(of: 2) {
        let rightNum = sortedArray[count/2]
        let leftNum = sortedArray[count/2 - 1]
        return (leftNum + rightNum)/2
    } else {
        return sortedArray[count/2]
    }
    
}

func mode(array: [Int]) -> [Int] {
    var dictNumberToMode = [Int: Int]() // [number : mode of this number], example [1, 1 ,4] -> [1: 2, 4: 1]
    var modeNumbers = [Int]()
    var counterForModeNumbers = 1
    for element in array {
        let mode = dictNumberToMode[element]
        switch mode {
        case nil:
            if counterForModeNumbers > 1 {
                dictNumberToMode[element] = 1
            } else {
                dictNumberToMode[element] = 1
                modeNumbers.append(element)
            }
        case let mode? where (mode + 1) > counterForModeNumbers:
            dictNumberToMode[element]! += 1
            counterForModeNumbers += 1
            modeNumbers = [element]
            
        case let mode? where (mode + 1) < counterForModeNumbers:
            dictNumberToMode[element]! += 1
            
        case let mode? where (mode + 1) == counterForModeNumbers:
            dictNumberToMode[element]! += 1
            modeNumbers.append(element)

        default:
            return []
        }
    }
    
    return modeNumbers
}

func quickSort(array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    
    var less = [Int]()
    var greater = [Int]()
    var equal = [Int]()
    let pivot = array[array.count/2]
    for elem in array {
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
    
    return quickSort(array: less) + equal + quickSort(array: greater)
}

let seq: [Int] = [1, 1, 2, 2, 3, 3, 3, 2, 4]

mean(array: seq)
median(array: seq)
mode(array: seq)
