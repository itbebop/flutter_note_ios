<?php
header('Content-Type: application/json');
include "../flutter_api/db.php";

// PDO 이용한 구현
// $stmt = $db->prepare("SELECT id, name, age, createdAt FROM student");
// $stmt->execute();
// $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
// echo json_encode($result);

// mysqli 이용한 구현
$stmt = "SELECT id, name, age, createdAt FROM student";

# 쿼리 실행
$result = mysqli_query($db, $stmt);
$result_array = array();
# 루프 돌며 배열에 오브젝트 하나씩 담기
# mysqli_fetch_array 사용 옵션 : MYSQLI_NUM : 키를 숫자로 사용 $row[0], MYSQLI_ASSOC : 키를 데이터키로 사용 $row["col1"], MYSQLI_BOTH : 둘다 사용
while($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
    $result_array[] = $row;
}
# 결과값 json 형식으로 변환
echo json_encode($result_array);

mysqli_close($db);