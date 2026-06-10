package servlet;

import java.io.IOException;
import java.util.List;

import dao.StudentDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Student;

public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "dashboard";
        }

        switch (action) {
            case "view":
                viewAllStudents(request, response);
                break;
            case "showAddForm":
                showAddForm(request, response);
                break;
            case "showUpdatePage":
                showUpdatePage(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "showDeletePage":
                showDeletePage(request, response);
                break;
            case "delete":
                deleteStudent(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("student");
            return;
        }

        switch (action) {
            case "add":
                addStudent(request, response);
                break;
            case "update":
                updateStudent(request, response);
                break;
            default:
                response.sendRedirect("student");
                break;
        }
    }

        private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalStudents = studentDAO.getTotalStudents();
        int totalDepartments = studentDAO.getDepartmentCount();

        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("totalDepartments", totalDepartments);

        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

        private void viewAllStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        request.setAttribute("studentCount", students.size());

        RequestDispatcher dispatcher = request.getRequestDispatcher("viewStudents.jsp");
        dispatcher.forward(request, response);
    }

        private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher = request.getRequestDispatcher("addStudent.jsp");
        dispatcher.forward(request, response);
    }

        private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");
        String dept = request.getParameter("dept");

        if (name == null || ageStr == null || dept == null ||
            name.trim().isEmpty() || ageStr.trim().isEmpty() || dept.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("addStudent.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            int age = Integer.parseInt(ageStr.trim());

            if (age < 1 || age > 120) {
                request.setAttribute("error", "Age must be between 1 and 120.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("addStudent.jsp");
                dispatcher.forward(request, response);
                return;
            }

            Student student = new Student(name.trim(), age, dept.trim());
            boolean success = studentDAO.addStudent(student);

            if (success) {
                response.sendRedirect("student?action=view&msg=Student+added+successfully");
            } else {
                request.setAttribute("error", "Failed to add student. Please try again.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("addStudent.jsp");
                dispatcher.forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Please enter a valid numeric age.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("addStudent.jsp");
            dispatcher.forward(request, response);
        }
    }

        private void showUpdatePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        request.setAttribute("studentCount", students.size());

        RequestDispatcher dispatcher = request.getRequestDispatcher("updateStudent.jsp");
        dispatcher.forward(request, response);
    }

        private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("student?action=showUpdatePage&error=Student+ID+is+required");
            return;
        }

        try {
            int id = Integer.parseInt(idParam.trim());
            Student student = studentDAO.getStudentById(id);

            if (student != null) {
                List<Student> students = studentDAO.getAllStudents();
                request.setAttribute("students", students);
                request.setAttribute("studentCount", students.size());
                request.setAttribute("editStudent", student);
                RequestDispatcher dispatcher = request.getRequestDispatcher("updateStudent.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("student?action=showUpdatePage&error=Student+not+found");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("student?action=showUpdatePage&error=Invalid+student+ID");
        }
    }

        private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");
        String dept = request.getParameter("dept");

        if (idStr == null || name == null || ageStr == null || dept == null ||
            idStr.trim().isEmpty() || name.trim().isEmpty() || ageStr.trim().isEmpty() || dept.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            try {
                int id = Integer.parseInt(idStr.trim());
                request.setAttribute("editStudent", studentDAO.getStudentById(id));
            } catch (Exception ignored) {}
            List<Student> students = studentDAO.getAllStudents();
            request.setAttribute("students", students);
            request.setAttribute("studentCount", students.size());
            RequestDispatcher dispatcher = request.getRequestDispatcher("updateStudent.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idStr.trim());
            int age = Integer.parseInt(ageStr.trim());

            if (age < 1 || age > 120) {
                request.setAttribute("error", "Age must be between 1 and 120.");
                request.setAttribute("editStudent", studentDAO.getStudentById(id));
                List<Student> students = studentDAO.getAllStudents();
                request.setAttribute("students", students);
                request.setAttribute("studentCount", students.size());
                RequestDispatcher dispatcher = request.getRequestDispatcher("updateStudent.jsp");
                dispatcher.forward(request, response);
                return;
            }

            Student student = new Student(id, name.trim(), age, dept.trim());
            boolean success = studentDAO.updateStudent(student);

            if (success) {
                response.sendRedirect("student?action=showUpdatePage&msg=Student+updated+successfully");
            } else {
                request.setAttribute("error", "Failed to update student. Please try again.");
                request.setAttribute("editStudent", studentDAO.getStudentById(id));
                List<Student> students = studentDAO.getAllStudents();
                request.setAttribute("students", students);
                request.setAttribute("studentCount", students.size());
                RequestDispatcher dispatcher = request.getRequestDispatcher("updateStudent.jsp");
                dispatcher.forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input values.");
            List<Student> students = studentDAO.getAllStudents();
            request.setAttribute("students", students);
            request.setAttribute("studentCount", students.size());
            RequestDispatcher dispatcher = request.getRequestDispatcher("updateStudent.jsp");
            dispatcher.forward(request, response);
        }
    }

        private void showDeletePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        request.setAttribute("studentCount", students.size());

        RequestDispatcher dispatcher = request.getRequestDispatcher("deleteStudent.jsp");
        dispatcher.forward(request, response);
    }

        private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("student?action=showDeletePage&error=Student+ID+is+required");
            return;
        }

        try {
            int id = Integer.parseInt(idParam.trim());
            boolean success = studentDAO.deleteStudent(id);

            if (success) {
                response.sendRedirect("student?action=showDeletePage&msg=Student+deleted+successfully");
            } else {
                response.sendRedirect("student?action=showDeletePage&error=Failed+to+delete+student");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("student?action=showDeletePage&error=Invalid+student+ID");
        }
    }
}
