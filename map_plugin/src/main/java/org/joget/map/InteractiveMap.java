package org.joget.map;

import java.util.*;
import org.joget.apps.app.service.AppPluginUtil;
import org.joget.apps.app.service.AppUtil;
import org.joget.apps.userview.model.UserviewMenu;
import org.joget.plugin.base.Plugin;
import org.joget.plugin.base.PluginManager;

public class InteractiveMap extends UserviewMenu {
    
    private final static String MESSAGE_PATH = "message/interactiveMap";
    
    @Override
    public String getName() {
        return "Interactive Map";
    }
    
    @Override
    public String getVersion() {
        return "8.0";
    }
     
    @Override
    public String getClassName() {
        return getClass().getName();
    }
    
    
    @Override
    public String getLabel() {
        //support i18n
        return AppPluginUtil.getMessage("org.joget.map.InteractiveMap.pluginLabel", getClassName(), MESSAGE_PATH);
    }
  
    @Override
    public String getDescription() {
        //support i18n
        return AppPluginUtil.getMessage("org.joget.map.InteractiveMap.pluginDesc", getClassName(), MESSAGE_PATH);
    }
     
    @Override
    public String getPropertyOptions() {
        return AppUtil.readPluginResource(getClassName(), "/properties/interactiveMap.json", null, true, MESSAGE_PATH);
    }
     
    @Override
    public String getCategory() {
        return "Marketplace";
    }
    @Override
    public String getIcon() {
        //sorry, i am reuse the icon of other plugin here
        return "/plugin/org.joget.apps.userview.lib.HtmlPage/images/grid_icon.gif";
    }
     
    @Override
    public boolean isHomePageSupported() {
        return true; // Can use as first page of the userview
    }
     
    @Override
    public String getDecoratedMenu() {
        return null; // using default
    }
    
    @Override
    public String getRenderPage() {
        Map model = new HashMap();
        model.put("request", getRequestParameters());
        model.put("element", this);
         
        PluginManager pluginManager = (PluginManager)AppUtil.getApplicationContext().getBean("pluginManager");
        String content = pluginManager.getPluginFreeMarkerTemplate(model, getClass().getName(), "/templates/interactiveMap.ftl", null);
        return content;
    }

}
