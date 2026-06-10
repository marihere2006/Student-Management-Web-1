package model;

public class Student {
    private int id;
    private String name;
    private int age;
    private String dept;

    public Student() {
    }

    public Student(String name, int age, String dept) {
        this.name = name;
        this.age = age;
        this.dept = dept;
    }

    public Student(int id, String name, int age, String dept) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.dept = dept;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    @Override
    public String toString() {
        return "Student [id=" + id + ", name=" + name + ", age=" + age + ", dept=" + dept + "]";
    }
}
