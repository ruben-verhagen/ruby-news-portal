!function($){"use strict";$.support.pushState=window.history&&window.history.pushState&&window.history.replaceState&&!navigator.userAgent.match(/((iPod|iPhone|iPad).+\bOS\s+[1-4]|WebApps\/.+CFNetwork)/);var scrollModule={init:function(options,obj){obj.options=$.extend({scrollContainer:window,scrollPadding:100,scrollEventDelay:300},options),this.options=obj.options,this.container=obj.container,obj.scrollModule=this,this._toplock=!0,this._bottomlock=!0,this.scrollContainer=$(this.options.scrollContainer),this.updateEntities(),this.sortMarkers(),this.currentPage=null,this.container.on("jes:afterPageLoad",$.proxy(function(event,url,placement){if(this.updateEntities(),this.sortMarkers(),this.checkMarker(),"top"==placement){var offset=this.markers[1].top,scrollTop=this.scrollContainer.scrollTop();this.scrollContainer.scrollTop(scrollTop+offset)}},this)),this.bind()},updateEntities:function(){this.entities=$(this.options.entity,this.container)},sortMarkers:function(){var markers=[];$(".jes-marker",this.container).each(function(){markers.push({top:$(this).position().top,url:$(this).data("jesUrl")})}),this.markers=markers},checkMarker:function(){for(var newPage=this.markers[0],scrollTop=this.scrollContainer.scrollTop(),i=1;i<this.markers.length&&scrollTop>this.markers[i].top;i++)newPage=this.markers[i];newPage.url!=this.currentPage&&(this.currentPage=newPage.url,$(this.container).trigger("jes:scrollToPage",newPage.url))},bind:function(){this.scrollContainer.on("scroll.jes",$.proxy(function(event){this._tId||(this.scrollHandler(event),this._tId=setTimeout($.proxy(function(){this._tId=null},this),this.options.scrollEventDelay))},this))},unbind:function(){$(this.options.scrollContainer).off("scroll.jes")},scrollHandler:function(){var $scrollable=this.scrollContainer,$entities=this.entities,$firstEntity=$entities.first(),$lastEntity=$entities.last(),scrollTop=$scrollable.scrollTop(),height=$scrollable.height(),scrollBottom=scrollTop+height,topEntityPosition=$firstEntity.position().top,topTarget=topEntityPosition+this.options.scrollPadding,bottomEntityPosition=$lastEntity.outerHeight()+$lastEntity.position().top,bottomTarget=bottomEntityPosition-this.options.scrollPadding;topTarget>scrollTop?this._toplock||($(this.container).trigger("jes:topThreshold"),this._toplock=!0):this._toplock=!1,scrollBottom>bottomTarget?this._bottomlock||($(this.container).trigger("jes:bottomThreshold"),this._bottomlock=!0):this._bottomlock=!1,this.checkMarker()}},ajaxModule={init:function(options,obj){obj.options=$.extend({},options),this.options=obj.options,this.container=obj.container,this.setMarker($(this.options.entity,this.container).first(),location.href),obj.ajaxModule=this},loadPage:function(url,placement,callback){var actions={top:{find:"first",inject:"insertBefore"},bottom:{find:"last",inject:"insertAfter"}},action=actions[placement];this.container.trigger("jes:beforePageLoad",[url,placement]),$.get(url,null,$.proxy(function(_data){var data=$("<div>").html(_data),containerSelector=this.options.container,container=$(containerSelector,data).first();if(container.length){var entities=container.find(this.options.entity);"bottom"==placement&&entities.each(function(){var id=$(this).attr("id");id&&$("#"+id,this.container).remove()});var cursor=$(this.options.entity,containerSelector)[action.find]();entities[action.inject](cursor),this.setMarker(entities.first(),url)}$.isFunction(callback)&&callback(data),this.container.trigger("jes:afterPageLoad",[url,placement,data,entities])},this),"html")},setMarker:function(entity,url){entity.addClass("jes-marker").data("jesUrl",url)}},navigationModule={init:function(options,obj){obj.options=$.extend({nextPage:".pagination a[rel=next]",previousPage:".pagination a[rel=previous]"},options),this.options=obj.options,this.container=obj.container,$.each([{selector:this.options.nextPage,event:"jes:bottomThreshold.navigation",placement:"bottom"},{selector:this.options.previousPage,event:"jes:topThreshold.navigation",placement:"top"}],$.proxy(function(i,v){if(v.element=$(v.selector),v.element.length){var url=v.element.prop("href"),lock=!1,handler=function(){!lock&&url&&(lock=!0,obj.ajaxModule.loadPage(url,v.placement,$.proxy(function(data){var newElement=$(v.selector,$(data));newElement.length?(lock=!1,url=newElement.prop("href"),v.element.attr("href",url)):($(this).off(v.event),v.element.remove())},this)))};$(this.container).on(v.event,handler),$(v.element).on("click",$.proxy(function(ev){ev.preventDefault(),handler.apply(this.container)},this))}},this))}},pushStateHistory={init:function(options,obj){$.support.pushState&&obj.container.on("jes:scrollToPage",function(event,url){history.replaceState({},null,url)})}};$.endlessScroll=function(options){if(this.options=$.extend(!0,{container:"#container",entity:".entity",_modules:[ajaxModule,scrollModule,navigationModule,pushStateHistory],modules:[]},options),this.container=$(this.options.container),!this.container.length)throw"Container for endless scroll isn't available on the page";return $.merge(this.options.modules,this.options._modules),this.options.modules.forEach($.proxy(function(module){module.init(this.options,this)},this)),this}}(jQuery);