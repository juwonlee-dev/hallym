package hallym.club.budget.dao;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import hallym.club.budget.vo.BudgetVO;

@Mapper("budgetDAO")
public interface BudgetDAO {
	
	public List<BudgetVO> getBudget(Map<String, Object> params);
	public String getTotal(Map<String, Object> params);
	public void deleteBudget(Map<String, Object> params);
	public void insertBudget(Map<String, Object> params);
	
}
