<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Add a new student to the Student Management System database.">
    <title>Add Student — StudentHub</title>
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
            <li><a href="student?action=showAddForm" class="active"><span class="nav-icon">&#10133;</span> <span class="nav-label">Add New</span></a></li>
        </ul>
    </nav>

    <main class="container">

        <div class="page-header fade-in">
            <h2>Add New Student</h2>
            <p>Fill in the details below to register a new student in the system.</p>
        </div>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-error">&#10060; <%= error %></div>
        <% } %>

        <div class="form-container fade-in-up">
            <form id="add-student-form" action="student?action=add" method="POST">

                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" placeholder="e.g. John Doe" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label for="age">Age</label>
                    <input type="number" id="age" name="age" placeholder="e.g. 21" min="1" max="120" required>
                </div>

                <div class="form-group">
                    <label for="dept">Department</label>
                    <input type="text" id="dept" name="dept" placeholder="e.g. Computer Science" required autocomplete="off">
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success btn-block" id="btn-save">
                        &#128190; Save Student
                    </button>
                    <button type="reset" class="btn btn-secondary btn-block" id="btn-reset">
                        &#128260; Reset
                    </button>
                </div>

            </form>
        </div>

    </main>

    <footer class="footer">
        <p>&copy; 2026 StudentHub &mdash; Student Management System. Built with Java Servlets &amp; MySQL.</p>
    </footer>

</body>
</html>
