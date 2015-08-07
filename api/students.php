<?php
error_reporting(-1);
ini_set('display_errors', 'On');


class StudentManagement {
    protected $configs = [
        'database' => [
            'host' => 'localhost',
            'user' => 'root',
            'password' => '123456',
            'database' => 'angularjs'
        ]
    ];
    public $tableName = 'students';

    public function __construct()
    {
        @mysql_connect($this->configs['database']['hosts'], $this->configs['database']['user'], $this->configs['database']['password']) or die('Error connect to database');
        @mysql_select_db($this->configs['database']['database']) or die('Error select database' . $this->configs['database']['database']);
    }

    /**
    * Get all students
    * @return array Student list
    */
    public function getStudents()
    {
        $students = [];
        $sqlStatement = "SELECT * FROM $this->tableName ORDER BY id DESC";
        $queryStatement = mysql_query($sqlStatement);

        if (mysql_num_rows($queryStatement) > 0) {
            while($row = mysql_fetch_assoc($queryStatement)) {
                $students[] = $row;
            }
        }

        return $students;
    }

    /**
    * Get student by ID
    * @param int $studentID Student ID
    * @return array Student info
    */
    public function getStudent($studentID = 0)
    {
        $sqlStatement = "SELECT * FROM $this->tableName WHERE id = {$studentID} LIMIT 1";
        $student = [];

        $queryStatement = mysql_query($sqlStatement);

        if (mysql_num_rows($queryStatement) > 0) {
            $student = mysql_fetch_assoc($queryStatement);
        }

        return $student;
    }

    /**
    * Save student info
    * @param array $student Student info
    * @return boolean Update/Insert status
    */
    public function saveStudent($student)
    {
        if (is_array($student)) {
            $studentID = (isset($student['id']) ? $student['id'] : 0);
            unset($student['id']);

            $sqlStatement = "UPDATE $this->tableName SET ";
            foreach ($student as $field => $value) {
                $sqlStatement .= "{$field} = '$value',";
            }
            $sqlStatement = trim($sqlStatement, ",") . " WHERE id = {$studentID}";

            if ($studentID === 0) {
                $fields = array_keys($student);
                $values = array_values($student);

                $sqlStatement = "INSERT INTO $this->tableName(" . implode(",", $fields) . ") VALUES('" . implode("', '", $values) . "')";
            }

            $query = mysql_query($sqlStatement);
            return $query;
        }

        return false;
    }
}

$reqMethod = $_SERVER['REQUEST_METHOD'];
$action = (isset($_GET['action']) ? $_GET['action'] : "");
$studentManagement = new StudentManagement();

if ($reqMethod === "POST") {
    if ($action === "save") {
        $student = json_decode(file_get_contents("php://input"), true);
        $message = ['status' => false];

        if (count($student) >= 5 && $studentManagement->saveStudent($student)) {
            $message = [
                'status' => true,
                'message' => 'Save student successfull'
            ];

            if (isset($student['id'])) {
                $message['action'] = 'update';
            }
        }

        echo json_encode($message);
    }
} else if ($action === "student") {
    $studentID = (isset($_GET['id']) ? $_GET['id'] : 0);
    $student = [];

    if ($studentID > 0) {
        $student = $studentManagement->getStudent($studentID);
    }

    echo json_encode($student);
} else {
    echo json_encode($studentManagement->getStudents());
}
