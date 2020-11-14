# EasyEventBus

A publish/subscribe EventBus for ios.

## Installation

### Cocoapods

```ruby
pod 'EasyEventBus'
```

## Usage

### 1. Create an event object

For a type of event, you need to create an object that adopt `EasyEvent` protocol to provide an event key

```Swift
struct Person: EasyEvent {
    static var key: String {
        return "PostEventKey"
    }
}

// or

// Passing some data to Observer
struct Person: EasyEvent {
    static var key: String {
        return "PostEventKey"
    }
    
    let name: String
    let age: Int
}

```

### 2. Subscribe event

To subscribe an event, you need pass event type and observer type to the method

```Swift
// subscribe on main queue by default
EasyEventBus.shared.subscribe(event: Person.self, target: Observer.self) { (person) in
    // do someting with Person object on main queue
    print("name: \(person.name), age: \(person.age)")
}

// or
 
// assign a queue to subscribe event   
EasyEventBus.shared.subscribe(event: Person.self, target: Observer.self, queue: .global) { (person) in
    // do someting with Person object on global queue
    print("name: \(person.name), age: \(person.age)")
}
```

### 3. Post event

Post an event from any part of your code.

```Swift
let person = Person(name: "name", age: 20)

// All subscribers matching the Person.key will receive it
EasyEventBus.shared.post(event: person)

// or

// Post an event to the assign observer
EasyEventBus.shared.post(event: person, to: Observer.self)
```

### 4. Remove observer

```Swift
// Remove all subscribers matching the Person.key
EasyEventBus.shared.remove(event: Person.self)

// or

// Remove all subscribers that on assign Observer
EasyEventBus.shared.remove(target: Observer.self)

// or

// Remove all subscribers matching Person.key that on assign Observer
EasyEventBus.shared.remove(event: Person.self, for: ViewController.self)

// or

// Remove all subscribers
EasyEventBus.shared.removeAllObservers()
```