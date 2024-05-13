package vn.devpro.projectshoes.service;

import org.springframework.stereotype.Service;

import vn.devpro.projectshoes.model.SaleOrderProduct;


@Service
public class SaleOrderProductService extends BaseService<SaleOrderProduct>{
	@Override
	public Class<SaleOrderProduct> clazz(){
		return SaleOrderProduct.class;
	}
}
