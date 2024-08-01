import UIKit
import Combine

let namesPublisher = ["Roy", "Riya", "Andy"].publisher
let namesCancellable = namesPublisher.sink(receiveValue: {
    name in print(name)
})



let rollNumberPublisher = [1,2,3,4,5].publisher
let rollNumberCancellable = rollNumberPublisher.sink(receiveCompletion: {
    completion in
    switch completion {
    case .finished:
        print("Finished")
    case .failure(let error):
        print("Failure ", error)
    }
}, receiveValue: { value in
    print(value)
})

/* 
 #################### Subjects ##################
 
 A Subject is a special form of a Publisher, you can subscribe and dynamically add elements to it. There are currently 2 different kinds of Subjects in Combine
 1. PassthroughSubject: If you subscribe to it you will get all the events that will happen after you subscribed.
 2. CurrentValueSubject: will give any subscriber the most recent element and everything
 */

let passThroughSubject = PassthroughSubject<String,Error>()
passThroughSubject.send("hi 1")

let passThroughSubjectCancellable = passThroughSubject.sink(receiveCompletion: {
    completion in
    switch completion {
    case .finished:
        print("Finished")
    case .failure(let error):
        print("Error ", error)
    }
}, receiveValue: {
    value in print(value)
})
 
passThroughSubject.send("hi 2")


let currentValueSubject = CurrentValueSubject<String, Error>("Initial value")
currentValueSubject.send("second value")

let currentValueSubjectCancellable = currentValueSubject.sink(receiveCompletion: {
    completion in
    switch completion{
    case .finished:
        print("Finished")
    case .failure(let error):
        print("Failure ", error)
    }
}, receiveValue: {
    value in print(value)
})
currentValueSubject.send("third value")


// Just publisher is a special type of publisher that emits only one value

let justPublisher = Just("Hello Just publisher")
let justCancellable = justPublisher.sink { value in
    print(value)
}


// Sequence publisher
let numbers = [1,2,3,4,5].publisher
let doubleNumbers = numbers.map { $0 * 2 }
let numberCancellable = doubleNumbers.sink{
    value in print(value)
}


// Timer publisher
let timerPublisher = Timer.publish(every: 1, on: .current, in: .common)
let timerCancellable = timerPublisher.autoconnect().sink { timestamp in
//    print(timestamp)
}



let largeNumber = (0...100).publisher
let largeNumberCancellable = largeNumber.sink { num in
    print(num)
}

DispatchQueue.main.asyncAfter(deadline: .now() ){
    largeNumberCancellable.cancel()
}
