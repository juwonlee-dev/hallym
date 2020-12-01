package hallym.club.budget.service;

import java.util.List;
import java.util.Map;

import hallym.club.budget.vo.BudgetVO;

public interface BudgetService {

	public List<BudgetVO> getBudget(Map<String, Object> params);
	public int getTotal(Map<String, Object> params);
	public void deleteBudget(Map<String, Object> params);
	public void insertBudget(Map<String, Object> params);
}
