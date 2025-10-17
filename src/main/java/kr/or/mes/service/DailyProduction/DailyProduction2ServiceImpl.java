package kr.or.mes.service.DailyProduction;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mes.dao.daily.DailyProduction2DAO;
import kr.or.mes.dto.DailyProduction2DTO;

@Service
public class DailyProduction2ServiceImpl implements DailyProduction2Service {

    @Autowired
    private DailyProduction2DAO dailyDAO;

    @Override
    public List<DailyProduction2DTO> selectAllDailyProductionPlans() {
        return dailyDAO.selectAllDailyProductionPlans();
    }

    @Override
    public List<DailyProduction2DTO> selectDailyProductionByCondition(DailyProduction2DTO dto) {
        return dailyDAO.selectDailyProductionByCondition(dto);
    }

    @Override
    public DailyProduction2DTO selectDailyProductionByLotNumber(String lotNumber) {
        return dailyDAO.selectDailyProductionByLotNumber(lotNumber);
    }

    @Override
    public DailyProduction2DTO selectDailyProductionById(String dailyPlanId) {
        return dailyDAO.selectDailyProductionById(dailyPlanId);
    }

    @Override
    public int insertDailyProduction(DailyProduction2DTO dailyProduction) {
        normalizeStatusFields(dailyProduction);
        return dailyDAO.insertDailyProduction(dailyProduction);
    }

    @Override
    public String createDailyProduction(DailyProduction2DTO dailyProduction) {
        if (dailyProduction == null) return "요청 데이터가 없습니다.";
        if (dailyProduction.getParentLotNumber() == null || dailyProduction.getParentLotNumber().trim().length() == 0) {
            return "원본 LOT 번호가 필요합니다.";
        }
        if (dailyProduction.getProductCode() == null || dailyProduction.getProductCode().trim().length() == 0) {
            return "제품코드를 선택해주세요.";
        }
        if (dailyProduction.getPlannedQty() <= 0) {
            return "계획수량은 1 이상이어야 합니다.";
        }
        if (dailyProduction.getPlannedStartDate() == null || dailyProduction.getPlannedEndDate() == null) {
            return "계획일자를 입력해주세요.";
        }
        if (dailyProduction.getStatus() == null || dailyProduction.getStatus().trim().length() == 0) {
            dailyProduction.setStatus("Production");
        }

        // LOT 번호 자동 생성 로직 (parent_lot_number-01 형태)
        int maxSeq = dailyDAO.getMaxSequenceForParentLot(dailyProduction.getParentLotNumber());
        int nextSeq = maxSeq + 1;
        String newLotNumber = dailyProduction.getParentLotNumber() + "-" + String.format("%02d", nextSeq);
        dailyProduction.setLotNumber(newLotNumber);

        normalizeStatusFields(dailyProduction);

        int result = dailyDAO.insertDailyProduction(dailyProduction);
        return result > 0 ? "SUCCESS" : "금일 생산계획 등록에 실패했습니다.";
    }

    @Override
    public int updateDailyProduction(DailyProduction2DTO dailyProduction) {
        normalizeStatusFields(dailyProduction);
        return dailyDAO.updateDailyProduction(dailyProduction);
    }

    @Override
    public String updateDailyProductionInfo(DailyProduction2DTO dailyProduction) {
        if (dailyProduction == null || dailyProduction.getDailyPlanId() == null) {
            return "수정할 대상이 없습니다.";
        }
        if (dailyProduction.getPlannedQty() <= 0) {
            return "계획수량은 1 이상이어야 합니다.";
        }
        normalizeStatusFields(dailyProduction);
        int result = dailyDAO.updateDailyProduction(dailyProduction);
        return result > 0 ? "SUCCESS" : "금일 생산계획 수정에 실패했습니다.";
    }

    @Override
    public String deleteDailyProductionById(String dailyPlanId) {
        if (dailyPlanId == null || dailyPlanId.trim().length() == 0) {
            return "삭제할 대상이 없습니다.";
        }
        int result = dailyDAO.deleteDailyProductionById(dailyPlanId);
        return result > 0 ? "SUCCESS" : "삭제에 실패했습니다.";
    }

    @Override
    public String deleteDailyProductionByLotNumber(String lotNumber) {
        if (lotNumber == null || lotNumber.trim().length() == 0) {
            return "삭제할 대상이 없습니다.";
        }
        int result = dailyDAO.deleteDailyProductionByLotNumber(lotNumber);
        return result > 0 ? "SUCCESS" : "삭제에 실패했습니다.";
    }

    @Override
    public int updateDailyProductionStatus(DailyProduction2DTO dailyProduction) {
        normalizeStatusFields(dailyProduction);
        return dailyDAO.updateDailyProductionStatus(dailyProduction);
    }

    @Override
    public String updateDailyProductionStatusInfo(DailyProduction2DTO dailyProduction) {
        if (dailyProduction == null || dailyProduction.getDailyPlanId() == null) {
            return "대상이 없습니다.";
        }
        if (dailyProduction.getStatus() == null || dailyProduction.getStatus().trim().length() == 0) {
            return "상태를 입력해주세요.";
        }
        normalizeStatusFields(dailyProduction);
        int result = dailyDAO.updateDailyProductionStatus(dailyProduction);
        return result > 0 ? "SUCCESS" : "상태 변경에 실패했습니다.";
    }

    @Override
    public int updateDailyProductionActualQty(DailyProduction2DTO dailyProduction) {
        return dailyDAO.updateDailyProductionActualQty(dailyProduction);
    }

    @Override
    public String updateDailyProductionActualQtyInfo(DailyProduction2DTO dailyProduction) {
        if (dailyProduction == null || dailyProduction.getDailyPlanId() == null) {
            return "대상이 없습니다.";
        }
        if (dailyProduction.getActualQty() == null || dailyProduction.getActualQty().intValue() < 0) {
            return "실제 수량은 0 이상이어야 합니다.";
        }
        int result = dailyDAO.updateDailyProductionActualQty(dailyProduction);
        return result > 0 ? "SUCCESS" : "실제 수량 변경에 실패했습니다.";
    }

    @Override
    public int assignWorkerToDailyProduction(DailyProduction2DTO dailyProduction) {
        return dailyDAO.assignWorkerToDailyProduction(dailyProduction);
    }

    @Override
    public String assignWorkerToDailyProductionInfo(DailyProduction2DTO dailyProduction) {
        if (dailyProduction == null || dailyProduction.getDailyPlanId() == null) {
            return "대상이 없습니다.";
        }
        if (dailyProduction.getWorkerId() == null || dailyProduction.getWorkerId().trim().length() == 0) {
            return "작업자를 입력해주세요.";
        }
        int result = dailyDAO.assignWorkerToDailyProduction(dailyProduction);
        return result > 0 ? "SUCCESS" : "작업자 배정에 실패했습니다.";
    }

    @Override
    public List<DailyProduction2DTO> selectDailyProductionByStatus(String status) {
        return dailyDAO.selectDailyProductionByStatus(status);
    }

    @Override
    public List<DailyProduction2DTO> selectDailyProductionByParentLot(String parentLotNumber) {
        return dailyDAO.selectDailyProductionByParentLot(parentLotNumber);
    }

    @Override
    public int selectTotalDailyQtyByParentLot(String parentLotNumber) {
        return dailyDAO.selectTotalDailyQtyByParentLot(parentLotNumber);
    }

    @Override
    public int selectTotalActualQtyByParentLot(String parentLotNumber) {
        return dailyDAO.selectTotalActualQtyByParentLot(parentLotNumber);
    }

    @Override
    public DailyProduction2DTO selectProductionForDailySchedule(String parentLotNumber) {
        // 전체 생산계획에서 필요한 데이터를 읽어 금일 생산계획 생성에 활용하려면
        // 기존 Production2 DAO/Service를 통해 조회하도록 후속 연동
        // 현재는 Daily 전용 레이어만 구성하므로 null 반환
        return null;
    }

    @Override
    public DailyProduction2DTO getDailyProductionDetail(String dailyPlanId) {
        if (dailyPlanId == null || dailyPlanId.trim().length() == 0) {
            return null;
        }
        return dailyDAO.selectDailyProductionById(dailyPlanId);
    }

    @Override
    public DailyProduction2DTO getDailyProductionForEdit(String dailyPlanId) {
        if (dailyPlanId == null || dailyPlanId.trim().length() == 0) {
            return null;
        }
        return dailyDAO.selectDailyProductionById(dailyPlanId);
    }

    @Override
    public String startDailyProduction(String dailyPlanId) {
        if (dailyPlanId == null || dailyPlanId.trim().length() == 0) {
            return "금일 생산계획 ID가 올바르지 않습니다.";
        }
        
        DailyProduction2DTO dailyProduction = dailyDAO.selectDailyProductionById(dailyPlanId);
        if (dailyProduction == null) {
            return "해당 금일 생산계획을 찾을 수 없습니다.";
        }
        
        if (!"Production".equals(dailyProduction.getStatus())) {
            return "계획 상태의 금일 생산계획만 시작할 수 있습니다.";
        }
        
        dailyProduction.setStatus("work");
        dailyProduction.setActualStartDate(new java.sql.Date(System.currentTimeMillis()));
        dailyProduction.setUpdatedBy("SYSTEM");
        
        int updateResult = dailyDAO.updateDailyProduction(dailyProduction);
        if (updateResult > 0) {
            return "SUCCESS";
        } else {
            return "금일 생산계획 시작에 실패했습니다.";
        }
    }

    @Override
    public int getMaxSequenceForParentLot(String parentLotNumber) {
        return dailyDAO.getMaxSequenceForParentLot(parentLotNumber);
    }

    private void normalizeStatusFields(DailyProduction2DTO dto) {
        if (dto == null) return;
        String status = dto.getStatus();
        if (status == null) return;
        // Java 1.6 호환: 상태 파생 필드를 Service에서 세팅
        if ("Production".equals(status)) {
            dto.setStatusDisplayName("계획");
            dto.setCompleted(false);
            dto.setInProgress(false);
        } else if ("work".equals(status)) {
            dto.setStatusDisplayName("작업중");
            dto.setCompleted(false);
            dto.setInProgress(true);
        } else if ("quality".equals(status)) {
            dto.setStatusDisplayName("품질검사중");
            dto.setCompleted(false);
            dto.setInProgress(true);
        } else if ("inventory".equals(status)) {
            dto.setStatusDisplayName("완료");
            dto.setCompleted(true);
            dto.setInProgress(false);
        } else {
            dto.setStatusDisplayName(status);
        }
    }
}
