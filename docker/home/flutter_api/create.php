<?php
header('Content-Type: application/json');
include "../flutter_api/db.php";

$name = $_POST['name'];
$age = (int) $_POST['age'];
$createdAt = $_POST['createdAt'];

$stmt = $db->prepare("INSERT INTO student (name, age, createdAt) VALUES (?, ?, ?)");
// $result = $stmt->execute([$name, $age, $createdAt]);
$stmt->bind_param("sis", $name, $age, $createdAt);
$result = $stmt->execute();

echo json_encode([
'success' => $result
]);