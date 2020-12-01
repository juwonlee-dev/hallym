package hallym.club.budget.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import hallym.club.budget.dao.BudgetDAO;
import hallym.club.budget.service.BudgetService;
import hallym.club.budget.vo.BudgetVO;

@Service("budgetService")
public class BudgetServiceImpl implements BudgetService {
	
	@Resource(name = "budgetDAO")
	BudgetDAO budgetDAO;

	@Override
	public List<BudgetVO> getBudget(Map<String, Object> params) {
		
		return budgetDAO.getBudget(params);
	}

	@Override
	public int getTotal(Map<String, Object> params)  {
		int tot = 0;
		try {
			tot = budgetDAO.getTotal(params);
		} catch (Exception e) {
			System.err.println("[BudgetServiceImpl] getTotal ERR: " + e.getMessage());
		}
		return tot;
	}

	@Override
	public void deleteBudget(Map<String, Object> params) {
		budgetDAO.deleteBudget(params);
	}

	@Override
	public void insertBudget(Map<String, Object> params) {
		budgetDAO.insertBudget(params);
	}

}
