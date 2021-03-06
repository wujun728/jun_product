package com.lu.dynamicaop.modular.business.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lu.dynamicaop.modular.business.mapper.ArticleMapper;
import com.lu.dynamicaop.modular.business.model.Article;
import com.lu.dynamicaop.modular.business.service.IArticleService;
import org.springframework.stereotype.Service;

@Service
public class IArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements IArticleService {

    @Override
    public Object get01() {
        return this.baseMapper.selectById(96);
    }

    @Override
    public Object get02() {
        return this.baseMapper.selectById(96);
    }
}
