<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Delete a student record from the Student Management System.">
    <title>Delete Student — StudentHub</title>
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
            <h2>Delete Student</h2>
            <p>Select a student to remove from the database. This action cannot be undone.</p>
        </div>

        <%
            String msg = request.getParameter("msg");
            String error = request.getParameter("error");
        %>
        <% if (msg != null && !msg.isEmpty()) { %>
            <div class="alert alert-success">&#9989; <%= msg %></div>
        <% } %>
        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-error">&#10060; <%= error %></div>
        <% } %>

        <div class="table-container fade-in-up">

            <%
                List<Student> students = (List<Student>) request.getAttribute("students");
                Integer studentCount = (Integer) request.getAttribute("studentCount");
                int count = (studentCount != null) ? studentCount : 0;
            %>

            <div class="table-header">
                <h3>&#128465; Select a Student to Delete</h3>
                <span class="student-count"><%= count %> <%= (count == 1) ? "student" : "students" %></span>
            </div>

            <% if (students == null || students.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-icon">&#128218;</div>
                    <h3>No Students Found</h3>
                    <p>There are no students to delete.</p>
                    <a href="student" class="btn btn-primary">&#127968; Back to Dashboard</a>
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
                                        <a href="student?action=delete&id=<%= student.getId() %>" class="btn btn-danger btn-sm" title="Delete"
                                           onclick="return confirm('Are you sure you want to delete this student?');">
                                            &#128465; Delete
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
