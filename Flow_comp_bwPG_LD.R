LRSR_flow<-read.csv("LRSR_flow.csv")
LRSR_flow <-subset(LRSR_flow,LRSR_flow$Month=="May"|
                     LRSR_flow$Month=="June"|LRSR_flow$Month=="July")# for the same month period between Puerto Galera (PG) and Laguingingan
LRSR_flow$Site <- factor(LRSR_flow$Site, levels = c("PG","LD") )



library(ggplot2)
library(ggpubr)

## Flow velocity at three or two points in each site 

LR_plot<-ggplot(LRSR_flow,aes(x=Site,y=LR*100,fill=Site))+
  scale_fill_manual(values =  c("#FF9933","#00BA38")) +
  xlab("Site")+ ylab("Local retention (%)")+geom_boxplot()+
  theme_classic(base_size = 22, base_family = "sans")+ 
  stat_summary(fun=median, geom="point", size=3.5)+
  scale_shape_manual(values=c(18,1))+ guides(fill="none")+
  scale_y_continuous(limits = c(0,10) ,labels = scales::number_format(accuracy = 0.1))+
  theme(axis.text.x=element_text(size=22))
LR_plot
SR_plot<-ggplot(LRSR_flow,aes(x=Site,y=SR*100,fill=Site))+
  scale_fill_manual(values =  c("#FF9933","#00BA38")) +
  xlab("Site")+ ylab("Self-recruitment (%)")+geom_boxplot()+
  theme_classic(base_size = 22, base_family = "sans")+ 
  stat_summary(fun=median, geom="point", size=3.5)+
  scale_shape_manual(values=c(18,1))+ guides(fill="none")+
  scale_y_continuous(labels = scales::number_format(accuracy = 0.1))+
  theme(axis.text.x=element_text(size=22))
SR_plot

Mag6dmean_plot<-ggplot(LRSR_flow,aes(x=Site,y=Mean_mag6d,fill=Site))+
  scale_fill_manual(values =  c("#FF9933","#00BA38")) +
  xlab("Site")+ ylab("Velocity magnitude (m/s)")+geom_boxplot()+
  theme_classic(base_size = 22, base_family = "sans")+ 
  stat_summary(fun=median, geom="point", size=3.5)+
  scale_shape_manual(values=c(18,1))+ guides(fill="none")+
  scale_y_continuous(labels = scales::number_format(accuracy = 0.01))+
  theme(axis.text.x=element_text(size=22))
Mag6dmean_plot


East6dmean_plot<-ggplot(LRSR_flow,aes(x=Site,y=Mean_east6d,fill=Site))+
  scale_fill_manual(values =  c("#FF9933","#00BA38")) +
  xlab("Site")+ ylab("E-W velocity (m/s)")+geom_boxplot()+
  theme_classic(base_size = 22, base_family = "sans")+ 
  stat_summary(fun=median, geom="point", size=3.5)+
  scale_shape_manual(values=c(18,1))+ guides(fill="none")+
  scale_y_continuous(labels = scales::number_format(accuracy = 0.01))+
  theme(axis.text.x=element_text(size=22))
East6dmean_plot

North6dmean_plot<-ggplot(LRSR_flow,aes(x=Site,y=Mean_north6d,fill=Site))+
  scale_fill_manual(values =  c("#FF9933","#00BA38")) +
  xlab("Site")+ ylab("N-S velocity (m/s)")+geom_boxplot()+
  theme_classic(base_size = 22, base_family = "sans")+ 
  stat_summary(fun=median, geom="point", size=3.5)+
  scale_shape_manual(values=c(18,1))+ guides(fill="none")+
  scale_y_continuous(labels = scales::number_format(accuracy = 0.01))+
  theme(axis.text.x=element_text(size=22))
North6dmean_plot

ggarrange(Mag6dmean_plot,East6dmean_plot,North6dmean_plot,LR_plot,SR_plot,
          ncol = 5, nrow = 1)

