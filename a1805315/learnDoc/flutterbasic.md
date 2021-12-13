## Class

In flutter, to create some objects, we use class. In the class, we intial the data type first and use consructure function to intialize the data of the object.

```flutter
Class Action{
    String actionName;
    int age;
    int height;
    int weight;

    Action(this.actionName);
}
```

note that ... is a spread function that changes the list into individual objects.

when the value is set at the initialization and will never chnage in the future, we can use const to initialize the variable.
