-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: myblog
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `desc` varchar(256) NOT NULL,
  `content` longtext NOT NULL,
  `date` date NOT NULL,
  `click_num` int(11) NOT NULL,
  `love_num` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_author_id_01185df5_fk_user_profile_id` (`author_id`),
  CONSTRAINT `article_author_id_01185df5_fk_user_profile_id` FOREIGN KEY (`author_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (1,'进程调度','进程调度Algorithm','# 进程调度\r\n\r\n- 无论是在批处理系统还是分时系统中，用户进程数一般都多于处理机数、这将导致它们互相争夺处理机。另外，系统进程也同样需要使用处理机。这就要求进程调度程序按一定的策略，动态地把处理机分配给处于就绪队列中的某一个进程，以使之执行。\r\n\r\n# 进程的状态\r\n\r\n#### 基本状态\r\n- 等待态：等待某个事件的完成；\r\n- 就绪态：等待系统分配处理器以便运行；\r\n- 运行态：占有处理器正在运行。\r\n- 运行态→等待态 往往是由于等待外设，等待主存等资源分配或等待人工干预而引起的。\r\n- 等待态→就绪态 则是等待的条件已满足，只需分配到处理器后就能运行。\r\n- 运行态→就绪态 不是由于自身原因，而是由外界原因使运行状态的进程让出处理器，这时候就变成就绪态。例如时间片用完，或有更高优先级的进程来抢占处理器等。\r\n- 就绪态→运行态 系统按某种策略选中就绪队列中的一个进程占用处理器，此时就变成了运行态\r\n\r\n## 算法讲解\r\n\r\n- 进程调度算法：采用最高优先数优先的调度算法（即把处理机分配给优先数最高的进程）和先来先服务算法。\r\n\r\n- 每个进程有一个进程控制块（ PCB）表示。进程控制块可以包含如下信息：进程名、优先数、到达时间、需要运行时间、已用CPU时间、进程状态等等。\r\n\r\n- 进程的优先数及需要的运行时间可以事先人为地指定（也可以由随机数产生）。进程的到达时间为进程输入的时间。 \r\n\r\n- 进程的运行时间以时间片为单位进行计算。每个进程的状态可以是就绪 W（Wait）、运行R（Run）、或完成F（Finish）三种状态之一。\r\n\r\n- 就绪进程获得 CPU后都只能运行一个时间片。用已占用CPU时间加1来表示。 \r\n如果运行一个时间片后，进程的已占用 CPU时间已达到所需要的运行时间，则撤消该进程，如果运行一个时间片后进程的已占用CPU时间还未达所需要的运行时间，也就是进程还需要继续运行，此时应将进程的优先数减1（即降低一级），然后把它插入就绪队列等待CPU。每进行一次调度程序都打印一次运行进程、就绪队列、以及各个进程的 PCB，以便进行检查。重复以上过程，直到所要进程都完成为止。\r\n\r\n\r\n# 程序详情\r\n\r\n\r\n\r\n	#include \"stdio.h\"\r\n	#include <stdlib.h>\r\n	#define getpch(type) (type *)malloc(sizeof(type))\r\n	#define NULL 0\r\n	struct pcb /* 定义进程控制块PCB */\r\n	{\r\n	  char name[10];\r\n	  char state;\r\n	  int super;\r\n	  int ntime;\r\n	  int rtime;\r\n	  struct pcb *link;\r\n	} *ready = NULL, *p;\r\n\r\n	typedef struct pcb PCB;\r\n	void sort() /* 建立对进程进行优先级排列函数*/\r\n	{\r\n	  PCB *first, *second;\r\n	  int insert = 0;\r\n	  if ((ready == NULL) || ((p->super) > (ready->super))) /*优先级最大者,插入队首*/\r\n	  {\r\n		p->link = ready;\r\n		ready = p;\r\n	  }\r\n	  else /* 进程比较优先级,插入适当的位置中*/\r\n	  {\r\n		first = ready;\r\n		second = first->link;\r\n		while (second != NULL)\r\n		{\r\n		  if ((p->super) > (second->super)) /*若插入进程比当前进程优先数大,*/\r\n		  {                                 /*插入到当前进程前面*/\r\n			p->link = second;\r\n			first->link = p;\r\n			second = NULL;\r\n			insert = 1;\r\n		  }\r\n		  else /* 插入进程优先数最低,则插入到队尾*/\r\n		  {\r\n			first = first->link;\r\n			second = second->link;\r\n		  }\r\n		}\r\n		if (insert == 0)\r\n		  first->link = p;\r\n	  }\r\n	}\r\n	void input() /* 建立进程控制块函数*/\r\n	{\r\n	  int i, num;\r\n	  printf(\"\\n 请输入进程数?\");\r\n	  scanf(\"%d\", &num);\r\n	  for (i = 0; i < num; i++)\r\n	  {\r\n		printf(\"\\n 进程号No.%d:\\n\", i);\r\n		p = getpch(PCB);\r\n		printf(\"\\n 输入进程名:\");\r\n		scanf(\"%s\", p->name);\r\n		printf(\"\\n 输入进程优先数:\");\r\n		scanf(\"%d\", &p->super);\r\n		printf(\"\\n 输入进程运行时间:\");\r\n		scanf(\"%d\", &p->ntime);\r\n		printf(\"\\n\");\r\n		p->rtime = 0;\r\n		p->state = \'w\';\r\n		p->link = NULL;\r\n		sort(); /* 调用sort函数*/\r\n	  }\r\n	}\r\n	int space()\r\n	{\r\n	  int l = 0;\r\n	  PCB *pr = ready;\r\n	  while (pr != NULL)\r\n	  {\r\n		l++;\r\n		pr = pr->link;\r\n	  }\r\n	  return (l);\r\n	}\r\n	void disp(PCB *pr) /*建立进程显示函数,用于显示当前进程*/\r\n	{\r\n	  printf(\"\\n qname \\t state \\t super \\t ndtime \\t runtime \\n\");\r\n	  printf(\"|%s\\t\", pr->name);\r\n	  printf(\"|%c\\t\", pr->state);\r\n	  printf(\"|%d\\t\", pr->super);\r\n	  printf(\"|%d\\t\", pr->ntime);\r\n	  printf(\"|%d\\t\", pr->rtime);\r\n	  printf(\"\\n\");\r\n	}\r\n\r\n	void check() /* 建立进程查看函数 */\r\n	{\r\n	  PCB *pr;\r\n	  printf(\"\\n **** 当前正在运行的进程是:%s\", p->name); /*显示当前运行进程*/\r\n	  disp(p);\r\n	  pr = ready;\r\n	  printf(\"\\n ****当前就绪队列状态为:\\n\"); /*显示就绪队列状态*/\r\n	  while (pr != NULL)\r\n	  {\r\n		disp(pr);\r\n		pr = pr->link;\r\n	  }\r\n	}\r\n	void destroy() /*建立进程撤消函数(进程运行结束,撤消进程)*/\r\n	{\r\n	  printf(\"\\n 进程 [%s] 已完成.\\n\", p->name);\r\n	  free(p);\r\n	}\r\n	void running() /* 建立进程就绪函数(进程运行时间到,置就绪状态*/\r\n	{\r\n	  (p->rtime)++;\r\n	  if (p->rtime == p->ntime)\r\n		destroy(); /* 调用destroy函数*/\r\n	  else\r\n	  {\r\n		(p->super)--;\r\n		p->state = \'w\';\r\n		sort(); /*调用sort函数*/\r\n	  }\r\n	}\r\n	int main() /*主函数*/\r\n	{\r\n	  int len, h = 0;\r\n	  char ch;\r\n	  input();\r\n	  len = space();\r\n	  while ((len != 0) && (ready != NULL))\r\n	  {\r\n		ch = getchar();\r\n		h++;\r\n		printf(\"\\n The execute number:%d \\n\", h);\r\n		p = ready;\r\n		ready = p->link;\r\n		p->link = NULL;\r\n		p->state = \'R\';\r\n		check();\r\n		running();\r\n		printf(\"\\n 按任一键继续......\");\r\n		ch = getchar();\r\n	  }\r\n	  printf(\"\\n\\n 进程已经完成.\\n\");\r\n	  ch = getchar();\r\n	  return 0;\r\n	}\r\n\r\n\r\n\r\n# END','2020-02-01',10,10,'ChMkJ1Z4-OmIP-DSAAfHFk-s9YkAAGetwH43B4AB8cu908_wKfupp0.jpg',1),(2,'世界第一的linux发行版 —— Manjaro','也算是了却了自己的一个心事吧，之前一直想装个Arch Linux玩玩但是Arch Linux的安装实在是特别繁琐，于是在google的过程中发现了Linux发行版的排行榜，发现了Manjaro竟然已经到了全球第一的地位。[Manjaro](https://manjaro.org/)这个Linux发现版我之前也算了解过。','# 世界第一的linux发行版 —— Manjaro\r\n\r\n## 写在前面\r\n\r\n也算是了却了自己的一个心事吧，之前一直想装个Arch Linux玩玩但是Arch Linux的安装实在是特别繁琐，于是在google的过程中发现了Linux发行版的排行榜，发现了Manjaro竟然已经到了全球第一的地位。[Manjaro](https://manjaro.org/)这个Linux发现版我之前也算了解过。\r\n\r\n## 介绍\r\n\r\n**Manjaro官方版本**\r\n- xfce版(64)\r\n- kde版(64)\r\n- gnome版(64)\r\n- Architect版\r\n- Arm版\r\n- 32位版(xfce)\r\n- 社区版(deepin桌面版,等等)\r\n\r\n这些版本你在[Manjaro的官方网站](https://manjaro.org/)的下载页面可以查看到具体的区别\r\n\r\n![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9zMi5heDF4LmNvbS8yMDE5LzA3LzE4L1pqVkZTSy5wbmc)\r\n\r\n\r\n## 安装\r\n\r\n**1.下载镜像**\r\n\r\n[Manjaro下载地址](https://manjaro.org/get-manjaro/)\r\n\r\n**2.刻录镜像**\r\n\r\n这里我使用的是[refus](https://rufus.ie/)这个刻录软件\r\n![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9zMi5heDF4LmNvbS8yMDE5LzA3LzE4L1pqVjFsOC5wbmc)\r\n\r\n**这里是截取的官方的图所以显示ubuntu不要纠结**\r\n**如果弹窗提示请选择dd**\r\n\r\n**3.安装**\r\n\r\n这里简单说说基本就是这几个步骤\r\n\r\n- u盘启动\r\n- 选择安装\r\n- 重启\r\n\r\n## 系统配置\r\n\r\n先给大家看看我安装之后的样子\r\n\r\n[外链图片转存失败(img-T63oKB2R-1563452353429)(https://s2.ax1x.com/2019/07/18/ZjVWfx.png)]\r\n\r\n**先排列源**\r\n```bash\r\nsudo pacman-mirrors -g\r\n```\r\n**同步并优化（类似磁盘整理，固态硬盘无需操作）**\r\n```sudo pacman-optimize && sync```\r\n\r\n**升级系统**\r\n\r\n```sudo pacman -Syyu```\r\n\r\n**添加中科大源**\r\n打开配置文件在文件末尾添加\r\n\r\n\r\n	sudo nano /etc/pacman.conf\r\n	[archlinuxcn]\r\n	SigLevel = Optional TrustedOnly\r\n	Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch\r\n\r\n\r\n**导入GPG Key**\r\n```sudo pacman -Syy && sudo pacman -S archlinuxcn-keyring```\r\n现在可以安装软件了，比如 chrome 和搜狗拼音输入法\r\n\r\n**安装搜狗输入法**\r\n\r\n	sudo pacman -S fcitx-sogoupinyin\r\n	sudo pacman -S fcitx-im\r\n	sudo pacman -S fcitx-configtool # 图形化的配置工具\r\n\r\n\r\n**需要修改配置文件 ~/.xprofile\r\n添加如下语句**\r\n\r\n\r\n	export GTK_IM_MODULE=fcitx\r\n	export QT_IM_MODULE=fcitx\r\n	export XMODIFIERS=\"@im=fcitx\"\r\n\r\n\r\n**安装包管理工具yaourt**\r\n```pacman -S yaourt```\r\n\r\n这个管理工具可以帮助你安装aur源上的程序\r\n\r\n通过这个工具你可以安装deepin打包的各种软件，例如:\r\n- 微信\r\n- QQ\r\n- 百度网盘\r\n- 等等\r\n\r\n通过下面的语句安装\r\n\r\n	yaourt -S deepin-wine-qq\r\n	yaourt -S deepin-wine-pan\r\n	yaourt -S deepin-wine-wechat\r\n\r\n![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9zMi5heDF4LmNvbS8yMDE5LzA3LzE4L1pqZTBMRi5wbmc)\r\n\r\n安装的话就是输入对应的你想安装的程序前的序号即可\r\n\r\n**修复kde桌面运行deepin-wine程序闪退的错误**\r\n\r\n在非gnome桌面环境下，Deepin-Wine软件大部分不能启动，例如deepin-Tim，deepin-QQ以及微信等。按照DLM的说法，深度在打包Deepin-Wine软件时加入了对Gnome的依赖。通过安装```gnome-settings-daemon```即可解决。\r\n\r\n1.安装gnome-settings-daemon\r\n```sudo apt install gnome-settings-daemon```\r\n\r\n2.复制org.gnome.SettingsDaemon.XSettings.desktop\r\n```cp /etc/xdg/autostart/org.gnome.SettingsDaemon.XSettings.desktop ~/.config/autostart```\r\n\r\n3.设置org.gnome.SettingsDaemon.XSettings.desktop开机自启\r\n\r\n在KDE中的一个简单的配置方法是：打开```系统设置```->```开机和关机```->```自动启动```->```设置为已启用```->```最后注销登录```或者```重启电脑```即可打开Deepin-Wine软件。（其他非KDE桌面环境，方法自己参考）\r\n\r\n![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9zMi5heDF4LmNvbS8yMDE5LzA3LzE4L1pqZWJXdC5wbmc)\r\n\r\n**记得选择**高级中的如下选项\r\n\r\n![](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9zMi5heDF4LmNvbS8yMDE5LzA3LzE4L1pqbUNZbi5wbmc)\r\n\r\n然后你就可以正常运行deepin打包的wine软件了\r\n\r\n## 其他\r\n\r\n**常用软件安装**\r\n\r\n	谷歌浏览器\r\n	pacman -S google-chrome\r\n	国内版火狐浏览器\r\n	pacman -S firefox firefox-i18n-zh-cn\r\n	压缩解压缩\r\n	pacman -S file-roller unrar unzip p7zip\r\n	Git ssh\r\n	pacman -S git openssh\r\n	安装wps\r\n	yaourt -S wps-office\r\n	VSCode\r\n	pacman -S visual-studio-code-bin \r\n\r\n**pacman和yaourt常用命令**\r\n\r\n	安装 pacman -S\r\n	删除 pacman -R\r\n	移除已安装不需要软件包 pacman -Rs\r\n	删除一个包,所有依赖 pacman -Rsc\r\n	升级包 pacman -Syu\r\n	查询包数据库 pacman -Ss\r\n	搜索以安装的包 pacman -Qs\r\n	显示包大量信息 pacman -Si\r\n	本地安装包 pacman -Qi\r\n	清理包缓存 pacman -Sc \r\n\r\n\r\n## End','2020-01-31',43,30,'b28e1d1b24eabb2a42abc955758824d3.jpg',1),(3,'解决黑苹果Usb配件需要电源','这几天在使用u盘和移动硬盘的时候突然发现会出现一个问题','# 解决黑苹果Usb配件需要电源\r\n\r\n## 问题描述\r\n\r\n这几天在使用u盘和移动硬盘的时候突然发现会出现一个问题\r\n\r\n\r\n在远景论坛和tonymacx86上面搜寻了半天大概已经确定了问题\r\n\r\n**USB3.0没有完美驱动成功**\r\n\r\n\r\n\r\n## 问题解决\r\n\r\n众所周知安装黑苹果的过程中最难的一部分不是安装而是配置驱动，这让我想着如何是好，于是我就去GitHub上找到我当时下载EFI文件 的那个仓库中 仔细阅读了他的README文档，其中在这样一个文件夹里面找到了一个文件\r\n\r\n[Lenovo-T450-USB.kext](http://qiniusave.luoshaoqi.cn/Lenovo-T450-USB.kext.zip)\r\n\r\n他在README里面是这么描述的\r\n\r\n**Miscellaneous**\r\n\r\n- A collection of different kernel extensions that I could use with this build but are currently not in use. I keep them in this folder for quick access if I find my self in a situation where I need them so that I do not have to download them all over again. The most important kext in this directory is the USB-T450-Injector.kext file. It can be used to inject the systems proper USB configuration in the absence of a properly configured USBInjectall + .aml configuration file. Don\'t get rid of it. If your USB ports ever stop working just load this kext into the \"Other\" folder and reboot.\r\n- 意思是如果你使用USBinjectall+.aml文件有问题的话 可以用USB-T450-Injector.kext文件代替\r\n\r\n\r\n\r\n使用方法很简单\r\n\r\n- 打开terminal输入```diskutil list```\r\n- 找到EFI分区 使用```sudo diskutil mount [EFI分区盘名]```挂载EFI分区\r\n- 在EFI分区的CLOVER文件夹中的kext中的 Other中 删除之前的USBInjectall.kext替换为Lenovo-T450-USB.kext\r\n- 重启计算机即可，在我重启之后发现已经解决了问题\r\n\r\n\r\n如图所示速度也是USB3.0的速度，这时候就说明了我们的USB3.0已经完美驱动了\r\n\r\n\r\n\r\n\r\n\r\n## 解除USB端口数量限制补丁\r\n\r\n**使用方法**\r\n\r\n- 打开Clover Configurator 在这[下载](https://mackie100projects.altervista.org/)\r\n- 然后点击挂载分区输入密码后选择EFI文件 如图所示\r\n\r\n- 然后在内核和驱动补丁这一块点击四次加号按照名字加入如下内容\r\n\r\n\r\n	Comment: **USB** port limit patch #1 10.14.x modify by DalianSky(credit ydeng)\r\n\r\n	Name: com.apple.iokit.IO**USB**HostFamily\r\n\r\n	Find: 83FB0F0F\r\n\r\n	Replace: 83FB3F0F\r\n\r\n	MatchOS: 10.14.x\r\n\r\n\r\n\r\n	Comment: **USB** port limit patch #2 10.14.x modify by DalianSky(credit PMHeart)\r\n\r\n	Name: com.apple.iokit.IO**USB**HostFamily\r\n\r\n	Find: 83E30FD3\r\n\r\n	Replace: 83E33FD3\r\n\r\n	MatchOS: 10.14.x\r\n\r\n\r\n\r\n	Comment: **USB** Port limit patch #3 10.14.x modify by DalianSky(credits PMheart)\r\n\r\n	Name: com.apple.driver.usb.Apple**USB**XHCI\r\n\r\n	Find: 83FB0F0F\r\n\r\n	Replace: 83FB3F0F\r\n\r\n	MatchOS: 10.14.x\r\n\r\n\r\n\r\n	Comment: **USB** Port limit patch #4 10.14.x modify by DalianSky(credits PMheart)\r\n\r\n	Name: com.apple.driver.usb.Apple**USB**XHCI\r\n\r\n	Find: 83FF0F0F\r\n\r\n	Replace: 83FF3F0F\r\n\r\n	MatchOS: 10.14.x\r\n\r\n\r\n\r\n\r\n- 如图所示\r\n\r\n[[外链图片转存失败,源站可能有防盗链机制,建议将图片保存下来直接上传(img-2w7RxYxE-1581062224331)(https://s2.ax1x.com/2019/06/14/V47w3d.md.png)]](https://imgchr.com/i/V47w3d)\r\n\r\n\r\n\r\n- 然后command+s 保存关闭即可\r\n- 重启计算机即可解决问题\r\n\r\n\r\n\r\n# END','2020-02-07',5,0,'V4oDGd.md.png',1);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_categories`
--

DROP TABLE IF EXISTS `article_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_tags_article_id_tag_id_9ea24d7b_uniq` (`article_id`,`categories_id`),
  KEY `article_categories_categories_id_04fb129e_fk_categories_id` (`categories_id`),
  CONSTRAINT `article_categories_article_id_d0080745_fk_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`),
  CONSTRAINT `article_categories_categories_id_04fb129e_fk_categories_id` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_categories`
--

LOCK TABLES `article_categories` WRITE;
/*!40000 ALTER TABLE `article_categories` DISABLE KEYS */;
INSERT INTO `article_categories` VALUES (1,1,2),(2,2,1),(3,3,2);
/*!40000 ALTER TABLE `article_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can add group',3,'add_group'),(9,'Can change group',3,'change_group'),(10,'Can delete group',3,'delete_group'),(11,'Can view group',3,'view_group'),(12,'Can view permission',2,'view_permission'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add 用户表',6,'add_userprofile'),(22,'Can change 用户表',6,'change_userprofile'),(23,'Can delete 用户表',6,'delete_userprofile'),(24,'Can view 用户表',6,'view_userprofile'),(25,'Can add captcha store',7,'add_captchastore'),(26,'Can change captcha store',7,'change_captchastore'),(27,'Can delete captcha store',7,'delete_captchastore'),(28,'Can view captcha store',7,'view_captchastore'),(29,'Can add 文章表',8,'add_article'),(30,'Can change 文章表',8,'change_article'),(31,'Can delete 文章表',8,'delete_article'),(32,'Can add 分类表',9,'add_categories'),(33,'Can change 分类表',9,'change_categories'),(34,'Can delete 分类表',9,'delete_categories'),(35,'Can view 文章表',8,'view_article'),(36,'Can view 分类表',9,'view_categories'),(37,'Can add Bookmark',10,'add_bookmark'),(38,'Can change Bookmark',10,'change_bookmark'),(39,'Can delete Bookmark',10,'delete_bookmark'),(40,'Can add User Setting',11,'add_usersettings'),(41,'Can change User Setting',11,'change_usersettings'),(42,'Can delete User Setting',11,'delete_usersettings'),(43,'Can add User Widget',12,'add_userwidget'),(44,'Can change User Widget',12,'change_userwidget'),(45,'Can delete User Widget',12,'delete_userwidget'),(46,'Can add log entry',13,'add_log'),(47,'Can change log entry',13,'change_log'),(48,'Can delete log entry',13,'delete_log'),(49,'Can view Bookmark',10,'view_bookmark'),(50,'Can view log entry',13,'view_log'),(51,'Can view User Setting',11,'view_usersettings'),(52,'Can view User Widget',12,'view_userwidget'),(53,'Can add 博客配置表',14,'add_siteconfig'),(54,'Can change 博客配置表',14,'change_siteconfig'),(55,'Can delete 博客配置表',14,'delete_siteconfig'),(56,'Can view 博客配置表',14,'view_siteconfig'),(57,'Can add comment',15,'add_comment'),(58,'Can change comment',15,'change_comment'),(59,'Can delete comment',15,'delete_comment'),(60,'Can moderate comments',15,'can_moderate'),(61,'Can add comment flag',16,'add_commentflag'),(62,'Can change comment flag',16,'change_commentflag'),(63,'Can delete comment flag',16,'delete_commentflag'),(64,'Can view comment',15,'view_comment'),(65,'Can view comment flag',16,'view_commentflag'),(66,'Can add site',17,'add_site'),(67,'Can change site',17,'change_site'),(68,'Can delete site',17,'delete_site'),(69,'Can view site',17,'view_site');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captcha_captchastore`
--

DROP TABLE IF EXISTS `captcha_captchastore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `captcha_captchastore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_captchastore`
--

LOCK TABLES `captcha_captchastore` WRITE;
/*!40000 ALTER TABLE `captcha_captchastore` DISABLE KEYS */;
INSERT INTO `captcha_captchastore` VALUES (1,'RZGZ','rzgz','2afd38c587f3068949f0b4ba2ee4a977803fe2a9','2020-02-02 21:10:38.756613'),(2,'UBLN','ubln','c1542e90633b04653fe8fc0c1db4bf241e07a0fe','2020-02-02 21:11:34.612135'),(3,'YSDO','ysdo','3c38ebe5ec55ddc0b0860a494c49a3da70b2e7bb','2020-02-02 21:14:41.056692'),(4,'QXVZ','qxvz','ed781a3c85cd6201a8fb7edbdd0a86d1db7015a0','2020-02-02 21:19:21.772130'),(5,'RPWB','rpwb','fe6ddc29465ea059b33f3f9df957b76da9cf40db','2020-02-06 14:05:03.633725'),(6,'XSSM','xssm','4fea6f6642528863e8a502363634e2cecab380e2','2020-02-06 14:05:12.690251'),(7,'CGHG','cghg','901a268c30cced1b67e1889866cf695f7303577d','2020-02-06 14:05:13.798380'),(8,'VPAF','vpaf','a1d597be371a58e6233d9dd4ad34ea00eb8b80d7','2020-02-06 14:05:14.496014'),(9,'FBBI','fbbi','9472e86d51506d3ad68690116278fd0a88107139','2020-02-06 14:05:15.118858'),(10,'ZQUF','zquf','ebc1ab8ce35152b5328d49d3578ca389f003a2d1','2020-02-06 14:08:47.110242'),(11,'PHIH','phih','3ee8fcda740b878d2962efbe5c8c93f7bdafa6fd','2020-02-06 14:18:09.116842'),(12,'MVHK','mvhk','185d2ecbff0f483599fe1abb9c784e044b58597f','2020-02-06 14:18:10.239109'),(13,'MASO','maso','5089b8a7cae6b52f36105b84e047f35ea3816894','2020-02-06 14:18:11.049176'),(14,'BBUQ','bbuq','b1736419400f11b5a3a17d814f7d42b321bd19e8','2020-02-06 14:18:11.696940'),(15,'RZRH','rzrh','a2ca7936c7279f16b68261cfccc221962a16dace','2020-02-06 14:18:12.141875'),(16,'ZIED','zied','db7fa6449e6af71521769ac3c7fe76ec5e133a10','2020-02-06 14:18:12.623545'),(17,'VKTL','vktl','b97344c682193450666f7e88eebeb7c4f35e2253','2020-02-06 14:18:13.158049'),(18,'WMTO','wmto','ca0981f2efa66471e180c44dbf25277cc58e1cf4','2020-02-06 14:18:13.725691'),(19,'SYYI','syyi','22fa90cb43bec410af73a3a9843de71796ccfde0','2020-02-06 14:18:14.202234'),(20,'QZFL','qzfl','de337472f0b2a6754924d555b611507f77705d8c','2020-02-06 14:18:14.634708'),(21,'CPBW','cpbw','35921d8bc4e46984036a65980ae785c32db5f18c','2020-02-06 14:18:15.065492'),(22,'MGFN','mgfn','d84f01f8a145d9b1395eb8e1b131567891a9b2a4','2020-02-06 14:18:15.803183'),(23,'XTXG','xtxg','7b20881950a5a3eb503b9bb324927548822264e5','2020-02-06 14:20:54.908065'),(24,'KQHV','kqhv','e88572ea68dcbe3405829ded5cc6007ee25c4df9','2020-02-06 14:26:27.147357'),(25,'OOAS','ooas','add21f999586ea5d1dfc087fc4c04cba541d6011','2020-02-06 14:33:34.753107'),(26,'OGQT','ogqt','661f29840f437d4c7b3426a275a05dc6346e7974','2020-02-06 14:33:36.012451'),(27,'GRKN','grkn','b30a7fb003f79300554511f97eba44778300353e','2020-02-06 14:35:04.944124'),(28,'IMUI','imui','c81a00b4144d73deb01f1fd78e60c7458ab0e5bd','2020-02-06 14:35:15.183713'),(29,'WXTB','wxtb','56eac6c25c589bfc5cc885c621b17db03d729857','2020-02-06 14:35:17.682475'),(30,'UECO','ueco','c29676741a79d6538d14af8fd8915ac4dc4ebbf6','2020-02-06 14:37:37.868719'),(31,'JENR','jenr','ca3fefc11ce5b86f992f4dac94fcaf9d027d009f','2020-02-06 14:40:07.508350'),(32,'UUAZ','uuaz','99ca6aae0df139e1b4b247880aabdaadcd93398e','2020-02-06 14:40:18.499278'),(33,'VSVJ','vsvj','6be9a19d96cd9d87e009a37be1334aa4d077d529','2020-02-06 14:40:19.483205'),(34,'WTZM','wtzm','53531d2fb191b6a7f6eca466f34a4c5f8de3942b','2020-02-06 14:40:27.453987'),(35,'KDMO','kdmo','2caf6c84fb00b2b219288fd4f4647183cbde7158','2020-02-06 14:40:28.658251'),(36,'GAUG','gaug','9c3d83c659836c11d3f41490f661e010f5c81db8','2020-02-06 14:40:29.317887'),(37,'YIZN','yizn','d46ec798424b603a40696f14073b08634a5033dd','2020-02-06 14:40:29.820753'),(38,'ZOFF','zoff','1bebf0a2eef35c8e40cefd2f699dddb88b7f4245','2020-02-06 14:40:30.265043'),(39,'ZTJL','ztjl','23c4544221a9f502f30567f13a9514db480cf7ef','2020-02-06 14:40:30.806599'),(40,'HVGQ','hvgq','e4e7c35d41e098736395ad0debbab4137efd4d86','2020-02-06 14:40:31.297003'),(41,'JAIN','jain','2fd531ecda60cf4e5bb3f736789869ab9dc1ab19','2020-02-06 14:40:31.789963'),(42,'EOTB','eotb','e82d873c88ebf14be21626eefc00ef69d3827dda','2020-02-06 14:40:32.222977'),(43,'FUAL','fual','93775a60b396b886c43facdc90a3cb76c81a3108','2020-02-06 14:40:32.617081'),(44,'QNVU','qnvu','74a98831b443ee339836deed6dac7a241c7dcccc','2020-02-06 14:40:33.224550'),(45,'THVJ','thvj','7c8581bf0d8e6e9e7e8147e728e6628615d5db56','2020-02-06 14:40:33.667662'),(46,'BJRO','bjro','3e830e93aa27e3c9cbb4f6e53b38104886889904','2020-02-06 14:40:34.164689'),(47,'GYEE','gyee','50aaae769f0d3890e5abe9743b0727256d68cc10','2020-02-07 15:27:06.470816'),(48,'HQIL','hqil','f0361ea2a5d2485e103ef8c6dcc90b9fa1dbd470','2020-02-07 15:27:14.962403'),(49,'RHQD','rhqd','29359442f84b134dba69abace289b6aa65182df5','2020-02-07 15:32:14.580895'),(50,'EQFU','eqfu','f5aa18277c83747e6c05c09aa84c28304e8b9d92','2020-02-07 15:34:07.950190'),(51,'XKIH','xkih','b1122b5a08d17fed0678c6bf3cb2c78adb8a8adf','2020-02-07 15:34:37.183794'),(52,'AYDP','aydp','a4cd46c167be3a7d68ec57235e1d917ec08370d1','2020-02-07 15:36:30.489277'),(53,'GVIS','gvis','7db58317e187dd571c56ae7c54d3b7311ad7f152','2020-02-07 15:39:16.263036'),(54,'QEGO','qego','02f0e20fa59eab62a699ce606e4c9db8af76afbf','2020-02-07 15:39:16.284740'),(55,'JZVO','jzvo','b4a0f1bf8af4c38a9a9d8fe79df9bb6844daee99','2020-02-07 15:40:07.894034'),(56,'PQRC','pqrc','ab0286f1b11e95634bed1eac9f41fe0387f234d8','2020-02-07 15:40:10.018933'),(57,'LJRD','ljrd','919be62622ec741e1a0293b0c419af3a20a98bb8','2020-02-07 15:40:10.978406'),(58,'IAEK','iaek','5c4d598be7f625aa586ba34f4686faaebb12be9b','2020-02-07 15:41:32.274954'),(59,'FQFE','fqfe','9242eea0c218f3b3bdd778f99ca79c94b562bec3','2020-02-07 15:41:51.394654'),(60,'KNOK','knok','8ff56db00aee03b16b9c72f83927c7dc73b29c87','2020-02-07 15:42:55.360479'),(61,'JFIP','jfip','291f627bc8060707d0cba9903d52d6f9a2f63a38','2020-02-07 15:42:56.545764'),(62,'EHCC','ehcc','68fa8e2158b3918f989f6451af29e87e9edc616a','2020-02-07 15:42:57.353094'),(63,'OLDG','oldg','8476c05999747c338adb668cef74e4bdfdcf98f2','2020-02-07 15:43:15.894219'),(64,'FIXF','fixf','ec5da25712bde20e348c79a612e3018538b1b056','2020-02-07 15:44:41.509193'),(65,'TYSV','tysv','95cd4f0c8bd42b80225270add0640ced131fef78','2020-02-07 15:44:41.534030'),(66,'QLOQ','qloq','9f719435802ad53304bfb3868c8e6ff7ad6c8768','2020-02-07 15:45:08.761756'),(67,'PIMZ','pimz','0ea2be2d6fed2a095d5a2e7071debcceb4435fba','2020-02-07 15:46:51.578214'),(68,'HSEC','hsec','1e0dc9c509e1fe979c028e817e047189923ed883','2020-02-07 15:46:52.868549'),(69,'BYPW','bypw','5500f71283d39fe5506f9ed66825501c075f5449','2020-02-07 15:46:53.471361'),(70,'DKWS','dkws','ea946cb59920356631aba61f635ef170f2efd8e6','2020-02-07 15:46:54.079325'),(71,'XUPR','xupr','b71445f9b507793ce93d56d669623b8ac9e0e444','2020-02-07 15:46:54.710720'),(72,'PGFW','pgfw','e3c94eeb35cda3716d18e3253c4bdd98e4a39e01','2020-02-07 15:46:55.233335'),(73,'ASQZ','asqz','adba8eef37a14d9cf08170127833cef47dba6686','2020-02-07 15:46:55.702208'),(74,'KIVY','kivy','f5b4355a141a0dcb5508b4d297afbfefc34a1524','2020-02-07 15:47:20.626643'),(75,'QBDA','qbda','e07db82e7ee3b7063ad2dd3841fbf3558550ceb7','2020-02-07 15:47:48.512607'),(76,'KQBL','kqbl','6e9e23bfcd3a0640bd7d26c10dc9fa195d326ae3','2020-02-07 15:51:09.461271'),(77,'KDYD','kdyd','e3a24dfae039e0216f81a993e12438e01a781346','2020-02-18 12:48:45.167574');
/*!40000 ALTER TABLE `captcha_captchastore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Linux'),(2,'软件开发');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_user_profile_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_user_profile_id` FOREIGN KEY (`user_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comment_flags`
--

DROP TABLE IF EXISTS `django_comment_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comment_flags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flag` varchar(30) NOT NULL,
  `flag_date` datetime(6) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_comment_flags_user_id_comment_id_flag_537f77a7_uniq` (`user_id`,`comment_id`,`flag`),
  KEY `django_comment_flags_comment_id_d8054933_fk_django_comments_id` (`comment_id`),
  KEY `django_comment_flags_flag_8b141fcb` (`flag`),
  CONSTRAINT `django_comment_flags_comment_id_d8054933_fk_django_comments_id` FOREIGN KEY (`comment_id`) REFERENCES `django_comments` (`id`),
  CONSTRAINT `django_comment_flags_user_id_f3f81f0a_fk_user_profile_id` FOREIGN KEY (`user_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comment_flags`
--

LOCK TABLES `django_comment_flags` WRITE;
/*!40000 ALTER TABLE `django_comment_flags` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comment_flags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comments`
--

DROP TABLE IF EXISTS `django_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_pk` longtext NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(254) NOT NULL,
  `user_url` varchar(200) NOT NULL,
  `comment` longtext NOT NULL,
  `submit_date` datetime(6) NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `is_removed` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `django_comments_content_type_id_c4afe962_fk_django_co` (`content_type_id`),
  KEY `django_comments_site_id_9dcf666e_fk_django_site_id` (`site_id`),
  KEY `django_comments_user_id_a0a440a1_fk_user_profile_id` (`user_id`),
  KEY `django_comments_submit_date_514ed2d9` (`submit_date`),
  CONSTRAINT `django_comments_content_type_id_c4afe962_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_comments_site_id_9dcf666e_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`),
  CONSTRAINT `django_comments_user_id_a0a440a1_fk_user_profile_id` FOREIGN KEY (`user_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comments`
--

LOCK TABLES `django_comments` WRITE;
/*!40000 ALTER TABLE `django_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(14,'App','siteconfig'),(6,'App','userprofile'),(8,'article','article'),(9,'article','categories'),(3,'auth','group'),(2,'auth','permission'),(7,'captcha','captchastore'),(4,'contenttypes','contenttype'),(15,'django_comments','comment'),(16,'django_comments','commentflag'),(5,'sessions','session'),(17,'sites','site'),(10,'xadmin','bookmark'),(13,'xadmin','log'),(11,'xadmin','usersettings'),(12,'xadmin','userwidget');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-01-30 14:17:35.992657'),(2,'contenttypes','0002_remove_content_type_name','2020-01-30 14:17:36.033011'),(3,'auth','0001_initial','2020-01-30 14:17:36.093655'),(4,'auth','0002_alter_permission_name_max_length','2020-01-30 14:17:36.105862'),(5,'auth','0003_alter_user_email_max_length','2020-01-30 14:17:36.111807'),(6,'auth','0004_alter_user_username_opts','2020-01-30 14:17:36.118326'),(7,'auth','0005_alter_user_last_login_null','2020-01-30 14:17:36.124179'),(8,'auth','0006_require_contenttypes_0002','2020-01-30 14:17:36.126171'),(9,'auth','0007_alter_validators_add_error_messages','2020-01-30 14:17:36.131354'),(10,'auth','0008_alter_user_username_max_length','2020-01-30 14:17:36.137063'),(11,'App','0001_initial','2020-01-30 14:17:36.192055'),(12,'admin','0001_initial','2020-01-30 14:17:36.220883'),(13,'admin','0002_logentry_remove_auto_add','2020-01-30 14:17:36.230612'),(14,'article','0001_initial','2020-01-30 14:17:36.376651'),(15,'article','0002_auto_20200115_1301','2020-01-30 14:17:36.440266'),(16,'article','0003_auto_20200115_1310','2020-01-30 14:17:36.462101'),(17,'article','0004_auto_20200129_1257','2020-01-30 14:17:36.543096'),(18,'article','0005_auto_20200129_1308','2020-01-30 14:17:36.581244'),(19,'captcha','0001_initial','2020-01-30 14:17:36.590966'),(20,'sessions','0001_initial','2020-01-30 14:17:36.603118'),(21,'xadmin','0001_initial','2020-01-30 14:17:36.675038'),(22,'xadmin','0002_log','2020-01-30 14:17:36.710228'),(23,'xadmin','0003_auto_20160715_0100','2020-01-30 14:17:36.728255'),(24,'App','0002_userprofile_desc','2020-01-30 15:09:51.245010'),(25,'article','0006_auto_20200130_2056','2020-01-30 20:56:58.732841'),(26,'article','0007_auto_20200130_2112','2020-01-30 21:13:00.685612'),(27,'article','0008_auto_20200130_2115','2020-01-30 21:16:02.055919'),(28,'article','0009_auto_20200130_2126','2020-01-30 21:27:37.551434'),(29,'article','0010_auto_20200130_2131','2020-01-30 21:31:39.727471'),(30,'article','0011_auto_20200130_2132','2020-01-30 21:32:41.851024'),(31,'article','0012_auto_20200130_2142','2020-01-30 21:42:48.998223'),(32,'article','0013_auto_20200130_2148','2020-01-30 21:49:02.468099'),(33,'App','0003_siteconfig','2020-01-31 21:36:13.521121'),(34,'App','0004_auto_20200131_2141','2020-01-31 21:41:03.462542'),(35,'App','0005_auto_20200131_2149','2020-01-31 21:49:27.952819'),(36,'App','0006_siteconfig_icon','2020-01-31 22:18:23.883446'),(37,'App','0007_auto_20200131_2220','2020-01-31 22:20:40.376115'),(38,'sites','0001_initial','2020-02-03 12:30:25.422545'),(39,'django_comments','0001_initial','2020-02-03 12:30:25.579139'),(40,'django_comments','0002_update_user_email_field_length','2020-02-03 12:30:25.616309'),(41,'django_comments','0003_add_submit_date_index','2020-02-03 12:30:25.632722'),(42,'sites','0002_alter_domain_unique','2020-02-03 12:30:25.642026');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2pp5aafq0bot2u8zhf8s20r9u3q9f28w','MWY5OGIyZGVkNTA1ZWQ5MjZiMjk1ODYyOTFmNmJjZWI5ODU4YzYwYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4NGEwM2Y0ZDE5ZGMxZDRiZTUxZmUyYTkyYWEyNDljNzY0ZDlhODQyIiwiTElTVF9RVUVSWSI6W1siYXJ0aWNsZSIsImFydGljbGUiXSwiIl19','2020-02-21 15:59:00.256359'),('bid7t3xp5b8wmsakv4b3pym9wg0rbokd','MWY5OGIyZGVkNTA1ZWQ5MjZiMjk1ODYyOTFmNmJjZWI5ODU4YzYwYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4NGEwM2Y0ZDE5ZGMxZDRiZTUxZmUyYTkyYWEyNDljNzY0ZDlhODQyIiwiTElTVF9RVUVSWSI6W1siYXJ0aWNsZSIsImFydGljbGUiXSwiIl19','2020-02-13 14:30:39.818744'),('x3ahqiiueq3zx3ogbny8tajbf6f2vfue','NTdjOWMxZDk1NTRkMDE2NDI2YTJiNmY1YzQ0OTRhMWEwMTQwMTE5Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4NGEwM2Y0ZDE5ZGMxZDRiZTUxZmUyYTkyYWEyNDljNzY0ZDlhODQyIn0=','2020-03-04 15:08:17.452105');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_config`
--

DROP TABLE IF EXISTS `site_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_owner_desc` longtext NOT NULL,
  `site_owner_friends` longtext NOT NULL,
  `site_owner_github_addr` varchar(200) NOT NULL,
  `site_owner_id` int(11) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `site_owner_desc_short` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_config_site_owner_id_9b67a1cc_fk_user_profile_id` (`site_owner_id`),
  CONSTRAINT `site_config_site_owner_id_9b67a1cc_fk_user_profile_id` FOREIGN KEY (`site_owner_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_config`
--

LOCK TABLES `site_config` WRITE;
/*!40000 ALTER TABLE `site_config` DISABLE KEYS */;
INSERT INTO `site_config` VALUES (1,'# 自我介绍\r\n\r\n- 性别：男\r\n- 爱好：女\r\n- 年龄：老男人了\r\n- Github地址：[Github](https://github.com/RoWe98)\r\n\r\n\r\n这是我第一次拿Django框架做一个完整的项目，这个项目来源于我自己对于博客系统的使用\r\n这些年里我陆陆续续使用了很多的成熟的博客系统：\r\n\r\n- Hexo\r\n- Solo\r\n- CSDN\r\n- 博客园\r\n\r\n等等 这些都是我使用过的博客系统 但是在我自己看来，或多或少都有这有那的问题，\r\n于是我就自己想，有没有一款真正属于我自己的博客系统，于是乎RxBlog计划就开始了\r\n\r\nRxBlog基于Django开发，是一个轻量，快速的博客系统，代码完全开源。','http://zouchanglin.cn/;http://ningdali.com/;https://www.luoshaoqi.cn/','https://github.com/RoWe98',1,'YN0YZZUY6468AONC_5knC7Fh.png','这是我第一次拿Django框架做一个完整的项目，这个项目来源于我自己对于博客系统的使用，RxBlog基于Django开发，是一个轻量，快速的博客系统，代码完全开源。');
/*!40000 ALTER TABLE `site_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `github_addr` varchar(32) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `desc` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
INSERT INTO `user_profile` VALUES (1,'pbkdf2_sha256$36000$OdGmxC3etDJ7$3h1echeWCc4FD4FAIDUtgOxSBL6jOR+ShHBJAcqNSxc=','2020-02-19 15:08:17.447996',1,'rex','','','wzx8551517@163.com',1,1,'2020-01-30 14:19:55.771078','','','','desc'),(2,'pbkdf2_sha256$36000$OEfwFqnYayL0$FJOcs+OjkTgZMGIHUejP5EApy/kbipf6t/SPfBO0eqw=','2020-02-18 16:35:17.549855',0,'rexrowe','','','wzx8551517@163.com',0,1,'2020-01-30 14:20:50.146789','15929912002','https://github.com/RoWe98','','desc'),(3,'pbkdf2_sha256$36000$ZGYrfDYG7VnU$uWF6GTopHKM0iwx0yP4imCUGPLHrGwt4pMy+GGEqHaI=','2020-02-02 21:17:07.323466',0,'tomcat','','','luoshaoqi@hotmail.com',0,1,'2020-02-02 21:16:15.039047','15929921002','github.com/RoWe98','','desc'),(4,'pbkdf2_sha256$36000$1tubSnnIkWSN$51G7ob6gsQdB9ppXBTqAsmqo3jDc0RgSh4U19Qqpw9s=',NULL,0,'apache111','','','345862542@qq.com',0,1,'2020-02-06 15:08:12.395236','1111111','1111','','desc'),(5,'pbkdf2_sha256$36000$3sq7Lym4ECWk$2EQofoKMjXFmxVfePUaDAlPu3Lpr+3+KeUD0fq3J0gA=',NULL,0,'nginx111','','','15929912002@163.com',0,1,'2020-02-06 15:09:22.284641','17691062002','github.com/RoWe98','','desc');
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile_groups`
--

DROP TABLE IF EXISTS `user_profile_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_profile_groups_userprofile_id_group_id_634d6ad7_uniq` (`userprofile_id`,`group_id`),
  KEY `user_profile_groups_group_id_864f8fbf_fk_auth_group_id` (`group_id`),
  CONSTRAINT `user_profile_groups_group_id_864f8fbf_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_profile_groups_userprofile_id_3e52d209_fk_user_profile_id` FOREIGN KEY (`userprofile_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile_groups`
--

LOCK TABLES `user_profile_groups` WRITE;
/*!40000 ALTER TABLE `user_profile_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_profile_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile_user_permissions`
--

DROP TABLE IF EXISTS `user_profile_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profile_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_profile_user_permis_userprofile_id_permissio_881e08f1_uniq` (`userprofile_id`,`permission_id`),
  KEY `user_profile_user_pe_permission_id_f5abe73f_fk_auth_perm` (`permission_id`),
  CONSTRAINT `user_profile_user_pe_permission_id_f5abe73f_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_profile_user_pe_userprofile_id_663dc0ea_fk_user_prof` FOREIGN KEY (`userprofile_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile_user_permissions`
--

LOCK TABLES `user_profile_user_permissions` WRITE;
/*!40000 ALTER TABLE `user_profile_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_profile_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_bookmark`
--

DROP TABLE IF EXISTS `xadmin_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `url_name` varchar(64) NOT NULL,
  `query` varchar(1000) NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_bookmark_content_type_id_60941679_fk_django_co` (`content_type_id`),
  KEY `xadmin_bookmark_user_id_42d307fc_fk_user_profile_id` (`user_id`),
  CONSTRAINT `xadmin_bookmark_content_type_id_60941679_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_bookmark_user_id_42d307fc_fk_user_profile_id` FOREIGN KEY (`user_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_bookmark`
--

LOCK TABLES `xadmin_bookmark` WRITE;
/*!40000 ALTER TABLE `xadmin_bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_log`
--

DROP TABLE IF EXISTS `xadmin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `ip_addr` char(39) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` varchar(32) NOT NULL,
  `message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` (`content_type_id`),
  KEY `xadmin_log_user_id_bb16a176_fk_user_profile_id` (`user_id`),
  CONSTRAINT `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_log_user_id_bb16a176_fk_user_profile_id` FOREIGN KEY (`user_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_log`
--

LOCK TABLES `xadmin_log` WRITE;
/*!40000 ALTER TABLE `xadmin_log` DISABLE KEYS */;
INSERT INTO `xadmin_log` VALUES (1,'2020-01-30 14:21:31.154096','127.0.0.1','1','Linux','create','已添加。',9,1),(2,'2020-01-30 14:21:44.920176','127.0.0.1','2','软件开发','create','已添加。',9,1),(3,'2020-01-30 14:30:39.747571','127.0.0.1','1','进程调度','create','已添加。',8,1),(4,'2020-01-30 20:58:20.681997','192.168.1.2','1','进程调度','change','修改 image',8,1),(5,'2020-01-30 21:00:47.741732','192.168.1.2','1','进程调度','change','修改 image',8,1),(6,'2020-01-30 21:14:08.648663','192.168.1.2','1','进程调度','change','修改 image',8,1),(7,'2020-01-30 21:50:13.025803','192.168.1.2','1','进程调度','change','修改 image',8,1),(8,'2020-01-31 14:15:00.443597','192.168.1.2','2','世界第一的linux发行版 —— Manjaro','create','已添加。',8,1),(9,'2020-01-31 21:49:36.624632','192.168.1.2','1','SiteConfig object','create','已添加。',14,1),(10,'2020-01-31 22:22:30.914699','192.168.1.2','1','SiteConfig object','change','修改 site_owner_desc_short 和 icon',14,1),(11,'2020-02-01 21:14:57.514223','192.168.1.2','1','进程调度','change','修改 image 和 author',8,1),(12,'2020-02-02 13:49:48.559124','192.168.1.2','1','SiteConfig object','change','修改 site_owner_desc 和 icon',14,1),(13,'2020-02-07 15:59:00.175413','192.168.1.2','3','解决黑苹果Usb配件需要电源','create','已添加。',8,1);
/*!40000 ALTER TABLE `xadmin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_usersettings`
--

DROP TABLE IF EXISTS `xadmin_usersettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_usersettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(256) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_usersettings_user_id_edeabe4a_fk_user_profile_id` (`user_id`),
  CONSTRAINT `xadmin_usersettings_user_id_edeabe4a_fk_user_profile_id` FOREIGN KEY (`user_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_usersettings`
--

LOCK TABLES `xadmin_usersettings` WRITE;
/*!40000 ALTER TABLE `xadmin_usersettings` DISABLE KEYS */;
INSERT INTO `xadmin_usersettings` VALUES (1,'dashboard:home:pos','',1);
/*!40000 ALTER TABLE `xadmin_usersettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_userwidget`
--

DROP TABLE IF EXISTS `xadmin_userwidget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_userwidget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` varchar(256) NOT NULL,
  `widget_type` varchar(50) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_userwidget_user_id_c159233a_fk_user_profile_id` (`user_id`),
  CONSTRAINT `xadmin_userwidget_user_id_c159233a_fk_user_profile_id` FOREIGN KEY (`user_id`) REFERENCES `user_profile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_userwidget`
--

LOCK TABLES `xadmin_userwidget` WRITE;
/*!40000 ALTER TABLE `xadmin_userwidget` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_userwidget` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-19 18:43:29
