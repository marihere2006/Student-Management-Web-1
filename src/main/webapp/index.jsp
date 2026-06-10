<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (request.getAttribute("totalStudents") == null) {
        response.sendRedirect("student");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Student Management System — A modern web application for managing student records with full CRUD operations.">
    <title>Student Management System — Dashboard</title>
    <link rel="icon" type="image/png" href="images/logo.png">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <a href="student" class="navbar-brand">
            <img src="images/logo.png" alt="StudentHub Logo" style="height: 45px; width: auto; object-fit: contain;">
        </a>
        <ul class="navbar-nav">
            <li><a href="student" class="active"><span class="nav-icon">&#127968;</span> <span class="nav-label">Home</span></a></li>
            <li><a href="student?action=view"><span class="nav-icon">&#128065;</span> <span class="nav-label">Students</span></a></li>
            <li><a href="student?action=showAddForm"><span class="nav-icon">&#10133;</span> <span class="nav-label">Add New</span></a></li>
        </ul>
    </nav>

    <main class="container">

        <div class="page-header fade-in">
            <h2>Student Management Dashboard</h2>
            <p>Manage student records efficiently &mdash; add, view, update, and delete with ease.</p>
        </div>

        <div class="stats-row fade-in">
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("totalStudents") != null ? request.getAttribute("totalStudents") : "0" %></div>
                <div class="stat-label">Total Students</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= request.getAttribute("totalDepartments") != null ? request.getAttribute("totalDepartments") : "0" %></div>
                <div class="stat-label">Departments</div>
            </div>
        </div>

        <div class="dashboard-grid">

            <a href="student?action=view" class="dashboard-card" id="card-view">
                <div class="card-icon">&#128065;</div>
                <h3>View Students</h3>
                <p>Browse all student records in a beautifully organized table.</p>
                <span class="card-arrow">&rarr;</span>
            </a>

            <a href="student?action=showAddForm" class="dashboard-card" id="card-add">
                <div class="card-icon">&#10133;</div>
                <h3>Add Student</h3>
                <p>Register a new student by entering their name, age, and department information.</p>
                <span class="card-arrow">&rarr;</span>
            </a>

            <a href="student?action=showUpdatePage" class="dashboard-card" id="card-update">
                <div class="card-icon">&#9999;</div>
                <h3>Update Student</h3>
                <p>Modify existing student records. Select a student from the list and edit their details.</p>
                <span class="card-arrow">&rarr;</span>
            </a>

            <a href="student?action=showDeletePage" class="dashboard-card" id="card-delete">
                <div class="card-icon">&#128465;</div>
                <h3>Delete Student</h3>
                <p>Remove student records from the database with a confirmation prompt for safety.</p>
                <span class="card-arrow">&rarr;</span>
            </a>

        </div>

    </main>

    <footer class="footer">
        <p>&copy; 2026 StudentHub &mdash; Student Management System. Built with Java Servlets &amp; MySQL.</p>
    </footer>

</body>
</html>
