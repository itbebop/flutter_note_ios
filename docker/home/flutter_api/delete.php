<?php
header('Content-Type: application/json');
include "../flutter_api/db.php";

$id = (int) $_POST['id'];
$stmt = $db->prepare("DELETE FROM student WHERE id = ?");
$stmt->bind_param("i", $id);
$result = $stmt->execute();
// $result = $stmt->execute([$id]);

echo json_encode([
'id' => $id,
'success' => $result
]);

?>