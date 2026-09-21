# Kế hoạch cập nhật ngày feedback

## Phạm vi

Thêm ngày tạo feedback vào workflow `$s-feedback` và mẫu `HARNESS_FEEDBACK.md`. Không thay đổi behavior của plugin đã cài, không reinstall, không commit hoặc publish.

## Đặc tả và tiêu chí chấp nhận

- Mỗi feedback mới phải có trường `Ngày feedback` theo định dạng ISO `YYYY-MM-DD`.
- Ngày lấy theo ngày địa phương tại thời điểm ghi feedback.
- Khi chuyển feedback sang trạng thái đã xử lý, ngày gốc được giữ nguyên; chỉ bổ sung thông tin xử lý nếu cần.
- Skill phải hướng dẫn agent ghi ngày và template phải có ví dụ/cấu trúc tương ứng.
- Harness validator và skill validator phải pass.

## Increment thực hiện

1. Cập nhật hướng dẫn `$s-feedback` để bắt buộc trường ngày và định dạng.
2. Cập nhật template `HARNESS_FEEDBACK.md` để hiển thị trường ngày trong mỗi mục.
3. Đọc lại các file đã sửa và chạy `scripts/validate-harness.ps1`, quick validator UTF-8 và plugin validator.

## Rủi ro và hồi phục

Chỉ sửa hai file feedback; nếu kiểm tra thất bại, dừng và giữ nguyên thay đổi để rà soát. Không tác động plugin cá nhân.

