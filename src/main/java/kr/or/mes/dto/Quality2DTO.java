package kr.or.mes.dto;

import java.util.Date;

/**
 * 품질검사 DTO 클래스
 * 품질검사 정보를 담는 데이터 전송 객체
 */
public class Quality2DTO {
    
    private String inspectionNo;      // 검사번호
    private String workOrderNo;       // 작업지시번호
    private String lotNumber;         // LOT번호
    private String status;            // 상태 (PENDING, PASS, FAIL, HOLD)
    private String inspectorId;       // 검사자 ID
    private String inspectorName;     // 검사자명
    private Integer goodQty;          // 양품수량
    private Integer defectQty;        // 불량수량
    private String defectReason;      // 불량사유
    private Date inspectionDate;      // 검사일
    private Date createdDate;         // 생성일
    private Date updatedDate;         // 수정일
    private String createdBy;         // 생성자
    private String updatedBy;         // 수정자
    
    // JOIN을 위한 추가 필드
    private String productCode;       // 제품코드
    private String productName;       // 제품명
    private Integer plannedQty;       // 계획수량
    private Integer actualQty;        // 실제수량
    private String workerId;          // 작업자 ID

    // 기본 생성자
    public Quality2DTO() {}

    // 전체 생성자
    public Quality2DTO(String inspectionNo, String workOrderNo, String lotNumber, 
                      String status, String inspectorId, String inspectorName,
                      Integer goodQty, Integer defectQty, String defectReason,
                      Date inspectionDate, Date createdDate, Date updatedDate,
                      String createdBy, String updatedBy) {
        this.inspectionNo = inspectionNo;
        this.workOrderNo = workOrderNo;
        this.lotNumber = lotNumber;
        this.status = status;
        this.inspectorId = inspectorId;
        this.inspectorName = inspectorName;
        this.goodQty = goodQty;
        this.defectQty = defectQty;
        this.defectReason = defectReason;
        this.inspectionDate = inspectionDate;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.createdBy = createdBy;
        this.updatedBy = updatedBy;
    }

    // Getter와 Setter
    public String getInspectionNo() {
        return inspectionNo;
    }

    public void setInspectionNo(String inspectionNo) {
        this.inspectionNo = inspectionNo;
    }

    public String getWorkOrderNo() {
        return workOrderNo;
    }

    public void setWorkOrderNo(String workOrderNo) {
        this.workOrderNo = workOrderNo;
    }

    public String getLotNumber() {
        return lotNumber;
    }

    public void setLotNumber(String lotNumber) {
        this.lotNumber = lotNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getInspectorId() {
        return inspectorId;
    }

    public void setInspectorId(String inspectorId) {
        this.inspectorId = inspectorId;
    }

    public String getInspectorName() {
        return inspectorName;
    }

    public void setInspectorName(String inspectorName) {
        this.inspectorName = inspectorName;
    }

    public Integer getGoodQty() {
        return goodQty;
    }

    public void setGoodQty(Integer goodQty) {
        this.goodQty = goodQty;
    }

    public Integer getDefectQty() {
        return defectQty;
    }

    public void setDefectQty(Integer defectQty) {
        this.defectQty = defectQty;
    }

    public String getDefectReason() {
        return defectReason;
    }

    public void setDefectReason(String defectReason) {
        this.defectReason = defectReason;
    }

    public Date getInspectionDate() {
        return inspectionDate;
    }

    public void setInspectionDate(Date inspectionDate) {
        this.inspectionDate = inspectionDate;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getPlannedQty() {
        return plannedQty;
    }

    public void setPlannedQty(Integer plannedQty) {
        this.plannedQty = plannedQty;
    }

    public Integer getActualQty() {
        return actualQty;
    }

    public void setActualQty(Integer actualQty) {
        this.actualQty = actualQty;
    }

    public String getWorkerId() {
        return workerId;
    }

    public void setWorkerId(String workerId) {
        this.workerId = workerId;
    }

    @Override
    public String toString() {
        return "Quality2DTO{" +
                "inspectionNo='" + inspectionNo + '\'' +
                ", workOrderNo='" + workOrderNo + '\'' +
                ", lotNumber='" + lotNumber + '\'' +
                ", status='" + status + '\'' +
                ", inspectorId='" + inspectorId + '\'' +
                ", inspectorName='" + inspectorName + '\'' +
                ", goodQty=" + goodQty +
                ", defectQty=" + defectQty +
                ", defectReason='" + defectReason + '\'' +
                ", inspectionDate=" + inspectionDate +
                ", createdDate=" + createdDate +
                ", updatedDate=" + updatedDate +
                ", createdBy='" + createdBy + '\'' +
                ", updatedBy='" + updatedBy + '\'' +
                '}';
    }
}