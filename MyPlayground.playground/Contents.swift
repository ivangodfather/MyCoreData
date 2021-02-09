import UIKit

var str = "Hello, playground"

var myIndexSet = IndexSet(arrayLiteral: 1,2,3,5)
print(myIndexSet.contains(4))
myIndexSet.insert(integersIn: 1...5)
print(myIndexSet.contains(4))
