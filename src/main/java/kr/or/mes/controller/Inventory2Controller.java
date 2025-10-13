package kr.or.mes.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.mes.dao.Inventory2DAO;
import kr.or.mes.dto.Inventory2DTO;

@Controller
public class Inventory2Controller {

    @Autowired
    Inventory2DAO dao;

    @RequestMapping("/inventoryList")
    public String inventoryList(Model model) {
        List<Inventory2DTO> list = dao.selectAll();
        model.addAttribute("list", list);
        return "inventory/inventoryList"; 
    }
}