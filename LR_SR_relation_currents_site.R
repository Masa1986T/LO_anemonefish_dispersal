### Flow velocity data at all grids in PG and LD and Local retention and Self-recruitment
LRSR_flow<-read.csv("LRSR_flow.csv",header=T)#Mean flow velocity at all  the grids of small domains in PG and LD
LRSR_flow$Site <- factor(LRSR_flow$Site, levels = c("PG","LD") )

#glm for Local retention (LR)
require(glmmTMB)
mod3 <- glmmTMB(LR~Site*(Mean_east6d+Mean_north6d),
                zi=~Site*(Mean_east6d+Mean_north6d),data=LRSR_flow,family=ziGamma(link = "log"))##Hurdle Gamma


library(MuMIn)
options(na.action = "na.fail")
bml3 <- dredge(mod3,rank="BIC")

mod.av_bml3<-model.avg(bml3, fit = TRUE)#Average over all models

summary(mod.av_bml3)#Check coefficients and SEs

####Local retention plots
###### Interaction effect between Site and East flow on LR
LRSR_flow_PG<-subset(LRSR_flow,Site=="PG")# PG data
dummy_LReast3_PG<- expand.grid(Site=c("PG"),Mean_north6d=mean(LRSR_flow$Mean_north6d),
                               Mean_east6d=seq(min(LRSR_flow_PG$Mean_east6d),max(LRSR_flow_PG$Mean_east6d),length=1000))
predLR_east_PG<- predict(mod.av_bml3,newdata=dummy_LReast3_PG,
                          se.fit=T)


LRline_east_PG<- exp(predLR_east_PG$fit)#estimate for PG data
LRlineh_east_PG<- exp(predLR_east_PG$fit+predLR_east_PG$se.fit*qnorm(0.975))#upper CI 
LRlinel_east_PG<- exp(predLR_east_PG$fit-predLR_east_PG$se.fit*qnorm(0.975))#lower CI
dummy_LReast3_PG$LRline_east_PG<-LRline_east_PG
dummy_LReast3_PG$LRlineh_east_PG<-LRlineh_east_PG
dummy_LReast3_PG$LRlinel_east_PG<-LRlinel_east_PG


LRSR_flow_LD<-subset(LRSR_flow,Site=="LD")
dummy_LReast3_LD<- expand.grid(Site=c("LD"),Mean_north6d=mean(LRSR_flow$Mean_north6d),
                               Mean_east6d=seq(min(LRSR_flow_LD$Mean_east6d),max(LRSR_flow_LD$Mean_east6d),length=1000))
predLR_east_LD <- predict(mod.av_bml3,newdata=dummy_LReast3_LD,
                          se.fit=T)

LRline_east_LD<- exp(predLR_east_LD$fit)#estimate for LD data
LRlineh_east_LD<- exp(predLR_east_LD$fit+predLR_east_LD$se.fit*qnorm(0.975))#upper CI 
LRlinel_east_LD<- exp(predLR_east_LD$fit-predLR_east_LD$se.fit*qnorm(0.975))#lower CI
dummy_LReast3_LD$LRline_east_LD<-LRline_east_LD
dummy_LReast3_LD$LRlineh_east_LD<-LRlineh_east_LD
dummy_LReast3_LD$LRlinel_east_LD<-LRlinel_east_LD

library(ggplot2)
LRSR_flow$Site <- factor(LRSR_flow$Site, levels = c("PG","LD") )

LR_mean_east_int<-ggplot(LRSR_flow,aes(x=Mean_east6d,y=LR,color=Site))+
  geom_point(size=3.5)+ scale_color_manual(labels = c("PG", "LD"),values = c("#FF9933","#00BA38"))+
  xlab("Mean E-W velocity (m/s)")+ ylab("Local retention")+ylim(0,0.10)+
  geom_ribbon(data=dummy_LReast3_PG, aes(x=Mean_east6d, ymin=LRlinel_east_PG, ymax=LRlineh_east_PG),
              fill="gray", alpha=0.5, inherit.aes = FALSE)+
  geom_line(data=dummy_LReast3_PG, aes(x=Mean_east6d, y=LRline_east_PG),linewidth=1,color="#FF9933",inherit.aes = FALSE)+
  geom_ribbon(data=dummy_LReast3_LD, aes(x=Mean_east6d, ymin=LRlinel_east_LD, ymax=LRlineh_east_LD),
              fill="gray", alpha=0.5, inherit.aes = FALSE)+
  geom_line(data=dummy_LReast3_LD, aes(x=Mean_east6d, y=LRline_east_LD),linewidth=1,color="#00BA38",inherit.aes = FALSE)+
  theme_classic(base_size = 22, base_family = "sans")+ 
  stat_summary(fun=median, geom="point", size=3.5)+
  scale_shape_manual(values=c(20,1))+
  theme(legend.justification=c(0.02,0.02), legend.position=c(0.77,0.7), 
        legend.title=element_text(size=23),legend.text =  element_text(size = 22))+
  theme(axis.title.x = element_blank())+
  theme(axis.text.x=element_text(size=20))+
  theme(axis.text.y=element_text(size=20))+
  theme(aspect.ratio=1)
LR_mean_east_int

##Interaction effect between Site and North flow on LR
LRSR_flow_PG<-subset(LRSR_flow,Site=="PG")
dummy_LRnorth3_PG<- expand.grid(Site=c("PG"),Mean_east6d=mean(LRSR_flow$Mean_east6d),
                                Mean_north6d=seq(min(LRSR_flow_PG$Mean_north6d),max(LRSR_flow_PG$Mean_north6d),length=1000))

predLR_north_PG <- predict(mod.av_bml3,newdata=dummy_LRnorth3_PG,
                           se.fit=T)

LRline_north_PG<- exp(predLR_north_PG$fit)#estimate for PG data
LRlineh_north_PG<- exp(predLR_north_PG$fit+predLR_north_PG$se.fit*qnorm(0.975))#upper CI 
LRlinel_north_PG<- exp(predLR_north_PG$fit-predLR_north_PG$se.fit*qnorm(0.975))#lower CI
dummy_LRnorth3_PG$LRline_north_PG<-LRline_north_PG
dummy_LRnorth3_PG$LRlineh_north_PG<-LRlineh_north_PG
dummy_LRnorth3_PG$LRlinel_north_PG<-LRlinel_north_PG

LRSR_flow_LD<-subset(LRSR_flow,Site=="LD")
dummy_LRnorth3_LD<- expand.grid(Site=c("LD"),Mean_east6d=mean(LRSR_flow$Mean_east6d),
                                Mean_north6d=seq(min(LRSR_flow_LD$Mean_north6d),max(LRSR_flow_LD$Mean_north6d),length=1000))
predLR_north_LD <- predict(mod.av_bml3,newdata=dummy_LRnorth3_LD,
                           se.fit=T)#Full model predict

LRline_north_LD<- exp(predLR_north_LD$fit)
LRlineh_north_LD<- exp(predLR_north_LD$fit+predLR_north_LD$se.fit*qnorm(0.975))#upper CI 
LRlinel_north_LD<- exp(predLR_north_LD$fit-predLR_north_LD$se.fit*qnorm(0.975))#lower CI
dummy_LRnorth3_LD$LRline_north_LD<-LRline_north_LD
dummy_LRnorth3_LD$LRlineh_north_LD<-LRlineh_north_LD
dummy_LRnorth3_LD$LRlinel_north_LD<-LRlinel_north_LD

library(ggplot2)
LR_mean_north_int<-ggplot(LRSR_flow,aes(x=Mean_north6d,y=LR,color=Site))+
  geom_point(size=3.5)+ scale_color_manual(labels = c("PG", "LD"),values = c("#FF9933","#00BA38"))+
  xlab("Mean E-W velocity (m/s)")+ ylab("Local retention")+ylim(0,0.10)+
  geom_ribbon(data=dummy_LRnorth3_PG, aes(x=Mean_north6d, ymin=LRlinel_north_PG, ymax=LRlineh_north_PG),
              fill="gray", alpha=0.5, inherit.aes = FALSE)+
  geom_line(data=dummy_LRnorth3_PG, aes(x=Mean_north6d, y=LRline_north_PG),linewidth=1,color="#FF9933",inherit.aes = FALSE)+
  geom_ribbon(data=dummy_LRnorth3_LD, aes(x=Mean_north6d, ymin=LRlinel_north_LD, ymax=LRlineh_north_LD),
              fill="gray", alpha=0.5, inherit.aes = FALSE)+
  geom_line(data=dummy_LRnorth3_LD, aes(x=Mean_north6d, y=LRline_north_LD),linewidth=1,color="#00BA38",inherit.aes = FALSE)+
  theme_classic(base_size = 22, base_family = "sans")+ 
  stat_summary(fun=median, geom="point", size=3.5)+
  scale_shape_manual(values=c(20,1))+
  guides(colour="none",shape="none")+
  theme(axis.title.x = element_blank())+
  theme(axis.title.y = element_blank())+
  theme(axis.text.x=element_text(size=20))+
  theme(axis.text.y=element_text(size=20))+
  theme(aspect.ratio=1)
LR_mean_north_int


#####glm for self-recruitment (SR)
mods3 <- glmmTMB(SR~Site*(Mean_east6d+Mean_north6d),
                 zi=~Site*(Mean_east6d+Mean_north6d),data=LRSR_flow,family=ziGamma(link = "log"))

options(na.action = "na.fail")
bmls3 <- dredge(mods3,rank="BIC")
mod.av_bmls3<-model.avg(bmls3, fit = TRUE)#Model averaging over all models

summary(mod.av_bmls3)#Check coefficients and SEs

###Interaction effect between Site and East flow on SR
LRSR_flow_PG<-subset(LRSR_flow,Site=="PG")
dummy_SReast3_PG<- expand.grid(Site=c("PG"),Mean_north6d=mean(LRSR_flow$Mean_north6d),
                               Mean_east6d=seq(min(LRSR_flow_PG$Mean_east6d),max(LRSR_flow_PG$Mean_east6d),length=1000))
predSR_east_PG <- predict(mod.av_bmls3,newdata=dummy_SReast3_PG,
                          se.fit=T)#Full model parameter


SRline_east_PG<- exp(predSR_east_PG$fit)
SRlineh_east_PG<- exp(predSR_east_PG$fit+predSR_east_PG$se.fit*qnorm(0.975))#upper CI 
SRlinel_east_PG<- exp(predSR_east_PG$fit-predSR_east_PG$se.fit*qnorm(0.975))#lower CI
dummy_SReast3_PG$SRline_east_PG<-SRline_east_PG
dummy_SReast3_PG$SRlineh_east_PG<-SRlineh_east_PG
dummy_SReast3_PG$SRlinel_east_PG<-SRlinel_east_PG

LRSR_flow_LD<-subset(LRSR_flow,Site=="LD")
dummy_SReast3_LD<- expand.grid(Site=c("LD"),Mean_north6d=mean(LRSR_flow$Mean_north6d),
                               Mean_east6d=seq(min(LRSR_flow_LD$Mean_east6d),max(LRSR_flow_LD$Mean_east6d),length=1000))
predSR_east_LD <- predict(mod.av_bmls3,newdata=dummy_SReast3_LD,
                          se.fit=T)#Full model 

SRline_east_LD<- exp(predSR_east_LD$fit)
SRlineh_east_LD<- exp(predSR_east_LD$fit+predSR_east_LD$se.fit*qnorm(0.975))#upper CI 
SRlinel_east_LD<- exp(predSR_east_LD$fit-predSR_east_LD$se.fit*qnorm(0.975))#lower CI
dummy_SReast3_LD$SRline_east_LD<-SRline_east_LD
dummy_SReast3_LD$SRlineh_east_LD<-SRlineh_east_LD
dummy_SReast3_LD$SRlinel_east_LD<-SRlinel_east_LD


library(ggplot2)
SR_mean_east_int<-ggplot(LRSR_flow,aes(x=Mean_east6d,y=SR,color=Site))+
  geom_point(size=3.5)+ scale_color_manual(labels = c("PG", "LD"),values = c("#FF9933","#00BA38"))+
  xlab("Mean E-W velocity (m/s)")+ ylab("Self-recruitment")+
  geom_ribbon(data=dummy_SReast3_PG, aes(x=Mean_east6d, ymin=SRlinel_east_PG, ymax=SRlineh_east_PG),
              fill="gray", alpha=0.5, inherit.aes = FALSE)+
  geom_line(data=dummy_SReast3_PG, aes(x=Mean_east6d, y=SRline_east_PG),size=1,color="#FF9933",inherit.aes = FALSE)+
  geom_ribbon(data=dummy_SReast3_LD, aes(x=Mean_east6d, ymin=SRlinel_east_LD, ymax=SRlineh_east_LD),
              fill="gray", alpha=0.5, inherit.aes = FALSE)+
  geom_line(data=dummy_SReast3_LD, aes(x=Mean_east6d, y=SRline_east_LD),size=1,color="#00BA38",inherit.aes = FALSE)+
  theme_classic(base_size = 22, base_family = "sans")+ 
  stat_summary(fun=median, geom="point", size=3.5)+
  scale_shape_manual(values=c(20,1))+
  guides(colour="none",shape="none")+
  theme(axis.text.x=element_text(size=20))+
  theme(axis.text.y=element_text(size=20))+
  theme(aspect.ratio=1)
SR_mean_east_int

###Interaction effect between Site and North flow on SR
LRSR_flow_PG<-subset(LRSR_flow,Site=="PG")
dummy_SRnorth3_PG<- expand.grid(Site=c("PG"),Mean_east6d=mean(LRSR_flow$Mean_east6d),
                               Mean_north6d=seq(min(LRSR_flow_PG$Mean_north6d),max(LRSR_flow_PG$Mean_north6d),length=1000))
predSR_north_PG <- predict(mod.av_bmls3,newdata=dummy_SRnorth3_PG,
                          se.fit=T)#Full model 

SRline_north_PG<- exp(predSR_north_PG$fit)
SRlineh_north_PG<- exp(predSR_north_PG$fit+predSR_north_PG$se.fit*qnorm(0.975))#upper CI
SRlinel_north_PG<- exp(predSR_north_PG$fit-predSR_north_PG$se.fit*qnorm(0.975))#lower CI
dummy_SRnorth3_PG$SRline_north_PG<-SRline_north_PG
dummy_SRnorth3_PG$SRlineh_north_PG<-SRlineh_north_PG
dummy_SRnorth3_PG$SRlinel_north_PG<-SRlinel_north_PG

LRSR_flow_LD<-subset(LRSR_flow,Site=="LD")
dummy_SRnorth3_LD<- expand.grid(Site=c("LD"),Mean_east6d=mean(LRSR_flow$Mean_east6d),
                                Mean_north6d=seq(min(LRSR_flow_LD$Mean_north6d),max(LRSR_flow_LD$Mean_north6d),length=1000))
predSR_north_LD <- predict(mod.av_bmls3,newdata=dummy_SRnorth3_LD,
                           se.fit=T)#Full model 

SRline_north_LD<- exp(predSR_north_LD$fit)
SRlineh_north_LD<- exp(predSR_north_LD$fit+predSR_north_LD$se.fit*qnorm(0.975))#upper CI
SRlinel_north_LD<- exp(predSR_north_LD$fit-predSR_north_LD$se.fit*qnorm(0.975))#lower CI
dummy_SRnorth3_LD$SRline_north_LD<-SRline_north_LD
dummy_SRnorth3_LD$SRlineh_north_LD<-SRlineh_north_LD
dummy_SRnorth3_LD$SRlinel_north_LD<-SRlinel_north_LD

library(ggplot2)
SR_mean_north_int<-ggplot(LRSR_flow,aes(x=Mean_north6d,y=SR,color=Site))+
  geom_point(size=3.5)+ scale_color_manual(labels = c("PG", "LD"),values = c("#FF9933","#00BA38"))+
  xlab("Mean N-S velocity (m/s)")+ ylab("Self-recruitment")+
  geom_ribbon(data=dummy_SRnorth3_PG, aes(x=Mean_north6d, ymin=SRlinel_north_PG, ymax=SRlineh_north_PG),
              fill="gray", alpha=0.5, inherit.aes = FALSE)+
  geom_line(data=dummy_SRnorth3_PG, aes(x=Mean_north6d, y=SRline_north_PG),size=1,color="#FF9933",inherit.aes = FALSE)+
  geom_ribbon(data=dummy_SRnorth3_LD, aes(x=Mean_north6d, ymin=SRlinel_north_LD, ymax=SRlineh_north_LD),
              fill="gray", alpha=0.5, inherit.aes = FALSE)+
  geom_line(data=dummy_SRnorth3_LD, aes(x=Mean_north6d, y=SRline_north_LD),size=1,color="#00BA38",inherit.aes = FALSE)+
  theme_classic(base_size = 22, base_family = "sans")+ 
  stat_summary(fun=median, geom="point", size=3.5)+
  scale_shape_manual(values=c(20,1))+
  guides(colour="none",shape="none")+
  theme(axis.title.y = element_blank())+
  theme(axis.text.x=element_text(size=20))+
  theme(axis.text.y=element_text(size=20))+
  theme(aspect.ratio=1)
SR_mean_north_int

library(ggpubr)
ggarrange(LR_mean_east_int,LR_mean_north_int,SR_mean_east_int,SR_mean_north_int,
          ncol = 2, nrow = 2,align = "hv")
