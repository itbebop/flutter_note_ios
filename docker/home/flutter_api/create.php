<?php
header('Content-Type: application/json');
include "../flutter_api/db.php";

$id = $_POST['id'];
$text = (int) $_POST['text'];
$createdAt = $_POST['createdAt'];

$stmt = $db->prepare("INSERT INTO note (id, content, createdAt) VALUES (?, ?, ?)");
// $result = $stmt->execute([$name, $age, $createdAt]);
$stmt->bind_param("sis", $name, $age, $createdAt);
$result = $stmt->execute();

echo json_encode([
'success' => $result
]);