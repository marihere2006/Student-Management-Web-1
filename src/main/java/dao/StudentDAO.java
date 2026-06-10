package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Student;
import util.DBUtil;

public class StudentDAO {

        public boolean addStudent(Student student) {
        String sql = "INSERT INTO students (name, age, dept) VALUES (?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, student.getName());
            ps.setInt(2, student.getAge());
            ps.setString(3, student.getDept());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

        public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT id, name, age, dept FROM students ORDER BY id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setName(rs.getString("name"));
                student.setAge(rs.getInt("age"));
                student.setDept(rs.getString("dept"));
                students.add(student);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return students;
    }

        public Student getStudentById(int id) {
        String sql = "SELECT id, name, age, dept FROM students WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setName(rs.getString("name"));
                    student.setAge(rs.getInt("age"));
                    student.setDept(rs.getString("dept"));
                    return student;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

        public boolean updateStudent(Student student) {
        String sql = "UPDATE students SET name = ?, age = ?, dept = ? WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, student.getName());
            ps.setInt(2, student.getAge());
            ps.setString(3, student.getDept());
            ps.setInt(4, student.getId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

        public boolean deleteStudent(int id) {
        String sql = "DELETE FROM students WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

        public int getTotalStudents() {
        String sql = "SELECT COUNT(*) FROM students";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

        public int getDepartmentCount() {
        String sql = "SELECT COUNT(DISTINCT dept) FROM students";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
}
