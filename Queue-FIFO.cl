class Main inherits IO {
    main() : Object {
        {
            out_string("Queue implementation in COOL\n");
            
            -- Test Queue
            let q : Queue <- new Queue in {
                q.init();
                q.enqueue(1);
                q.enqueue(2);
                q.enqueue(3);
                
                out_string("Queue contents: ");
                q.print();
                
                out_string("Front: ");
                case q.front() of
                    i : Int => out_int(i);
                    o : Object => out_string("Error");
                esac;
                out_string("\n");
                
                out_string("Dequeue: ");
                case q.dequeue() of
                    i : Int => out_int(i);
                    o : Object => out_string("Error");
                esac;
                out_string("\n");
                
                out_string("Queue after dequeue: ");
                q.print();
            };
        }
    };
};

class Queue inherits IO {
    items : List;
    
    init() : Queue {
        {
            items <- new Nil;
            self;
        }
    };
    
    enqueue(item : Int) : Queue {
        {
            items <- items.append(new Cons.init(item, new Nil));
            self;
        }
    };
    
    dequeue() : Object {
        if items.isEmpty() then
            {
                out_string("Queue is empty!\n");
                abort();
                new Object;
            }
        else
            let head_obj : Object <- items.head() in
            {
                items <- items.tail();
                head_obj;
            }
        fi
    };
    
    front() : Object {
        if items.isEmpty() then
            {
                out_string("Queue is empty!\n");
                abort();
                new Object;
            }
        else
            items.head()
        fi
    };
    
    isEmpty() : Bool {
        items.isEmpty()
    };
    
    print() : Object {
        items.print()
    };
};

class List inherits IO {
    isEmpty() : Bool { true };
    head() : Object { { abort(); new Object; } };
    tail() : List { { abort(); new Nil; } };
    append(l : List) : List { l };
    print() : Object { out_string("[]") };
};

class Cons inherits List {
    car : Int;
    cdr : List;
    
    init(head : Int, tail : List) : Cons {
        {
            car <- head;
            cdr <- tail;
            self;
        }
    };
    
    isEmpty() : Bool { false };
    
    head() : Object { car };
    
    tail() : List { cdr };
    
    append(l : List) : List {
        if cdr.isEmpty() then
            new Cons.init(car, l)
        else
            new Cons.init(car, cdr.append(l))
        fi
    };
    
    print() : Object {
        {
            out_string("[");
            print_helper(self);
            out_string("]");
        }
    };
    
    print_helper(l : List) : Object {
        if l.isEmpty() then
            true
        else
            case l.head() of
                i : Int => {
                    out_int(i);
                    if not l.tail().isEmpty() then
                        {
                            out_string(", ");
                            print_helper(l.tail());
                        }
                    else
                        true
                    fi;
                };
            esac
        fi
    };
};

class Nil inherits List {
    isEmpty() : Bool { true };
    
    append(l : List) : List { l };
    
    print() : Object {
        out_string("[]")
    };
};