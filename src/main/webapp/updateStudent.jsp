<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Update an existing student record in the Student Management System.">
    <title>Update Student — StudentHub</title>
    <link rel="icon" type="image/png" href="images/logo.png">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <a href="student" class="navbar-brand">
            <img src="images/logo.png" alt="StudentHub Logo" style="height: 45px; width: auto; object-fit: contain;">
        </a>
        <ul class="navbar-nav">
            <li><a href="student"><span class="nav-icon">&#127968;</span> <span class="nav-label">Home</span></a></li>
            <li><a href="student?action=view"><span class="nav-icon">&#128065;</span> <span class="nav-label">Students</span></a></li>
            <li><a href="student?action=showAddForm"><span class="nav-icon">&#10133;</span> <span class="nav-label">Add New</span></a></li>
        </ul>
    </nav>

    <main class="container">

        <div class="page-header fade-in">
            <h2>Update Student</h2>
            <p>Select a student to edit their details, then click "Update" to save changes.</p>
        </div>

        <%
            String msg = request.getParameter("msg");
            String error = request.getParameter("error");
            String errorAttr = (String) request.getAttribute("error");
        %>
        <% if (msg != null && !msg.isEmpty()) { %>
            <div class="alert alert-success">&#9989; <%= msg %></div>
        <% } %>
        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-error">&#10060; <%= error %></div>
        <% } %>
        <% if (errorAttr != null) { %>
            <div class="alert alert-error">&#10060; <%= errorAttr %></div>
        <% } %>

        <%
            Student editStudent = (Student) request.getAttribute("editStudent");
        %>

        <% if (editStudent != null) { %>
            <div class="form-container fade-in-up" style="margin-bottom: 2rem;">
                <form id="edit-student-form" action="student?action=update" method="POST">

                    <input type="hidden" name="id" value="<%= editStudent.getId() %>">

                    <div class="form-group">
                        <label for="student-id-display">Student ID</label>
                        <input type="text" id="student-id-display" value="#<%= editStudent.getId() %>" disabled
                               style="opacity: 0.6; cursor: not-allowed;">
                    </div>

                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" value="<%= editStudent.getName() %>"
                               placeholder="e.g. John Doe" required autocomplete="off">
                    </div>

                    <div class="form-group">
                        <label for="age">Age</label>
                        <input type="number" id="age" name="age" value="<%= editStudent.getAge() %>"
                               placeholder="e.g. 21" min="1" max="120" required>
                    </div>

                    <div class="form-group">
                        <label for="dept">Department</label>
                        <input type="text" id="dept" name="dept" value="<%= editStudent.getDept() %>"
                               placeholder="e.g. Computer Science" required autocomplete="off">
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary btn-block" id="btn-update">
                            &#9999; Update Student
                        </button>
                        <a href="student?action=showUpdatePage" class="btn btn-secondary btn-block" id="btn-cancel">
                            &#10006; Cancel
                        </a>
                    </div>

                </form>
            </div>
        <% } %>

        <div class="table-container fade-in-up">

            <%
                List<Student> students = (List<Student>) request.getAttribute("students");
                Integer studentCount = (Integer) request.getAttribute("studentCount");
                int count = (studentCount != null) ? studentCount : 0;
            %>

            <div class="table-header">
                <h3>&#128203; Select a Student to Update</h3>
                <span class="student-count"><%= count %> <%= (count == 1) ? "student" : "students" %></span>
            </div>

            <% if (students == null || students.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-icon">&#128218;</div>
                    <h3>No Students Found</h3>
                    <p>Add students first before updating.</p>
                    <a href="student?action=showAddForm" class="btn btn-primary">&#10133; Add Student</a>
                </div>
            <% } else { %>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Age</th>
                            <th>Department</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Student student : students) { %>
                            <tr>
                                <td class="td-id">#<%= student.getId() %></td>
                                <td class="td-name"><%= student.getName() %></td>
                                <td><%= student.getAge() %></td>
                                <td><span class="td-dept"><%= student.getDept() %></span></td>
                                <td>
                                    <div class="td-actions">
                                        <a href="student?action=edit&id=<%= student.getId() %>" class="btn btn-warning btn-sm" title="Edit">
                                            &#9999; Edit
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>

        </div>

    </main>

    <footer class="footer">
        <p>&copy; 2026 StudentHub &mdash; Student Management System. Built with Java Servlets &amp; MySQL.</p>
    </footer>

</body>
</html>
