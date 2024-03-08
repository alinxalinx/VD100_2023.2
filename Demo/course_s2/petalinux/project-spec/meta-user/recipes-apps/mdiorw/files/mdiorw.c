#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <linux/mii.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <linux/sockios.h>
#include <linux/types.h>
#include <netinet/in.h>
#include <unistd.h>
#include <errno.h>


int main(int argc, char *argv[])
{
    int sockfd = -1;
    struct mii_ioctl_data *mii = NULL;
    struct ifreq ifr;
    memset(&ifr, 0, sizeof(ifr));

    if(argc < 4) {
        printf("mdio ethX phyId reg [value]\n");
        return 0;
    }
    strncpy(ifr.ifr_name, argv[1], IFNAMSIZ - 1);
    sockfd = socket(PF_LOCAL, SOCK_DGRAM, 0);
    if(ioctl(sockfd, SIOCGMIIPHY, &ifr) < 0) {
        printf("SIOCGMIIPHY error:%s\n", strerror(errno));
        return 0;
    }
    mii = (struct mii_ioctl_data*)&ifr.ifr_data;
    mii->reg_num = (uint16_t)strtoul(argv[3], NULL, 16);
    printf("auto id:%d\n", mii->phy_id);
    if(argc == 4)
    {
        if(strtoul(argv[2], NULL, 16)) {
            mii->phy_id = (uint16_t)strtoul(argv[2], NULL, 16);
        }
        if(ioctl(sockfd, SIOCGMIIREG, &ifr) < 0) {
            printf("read error:%s\n", strerror(errno));
        }
        else {
            printf("R:id=%d reg=0x%08x value : 0x%x\n", mii->phy_id, mii->reg_num, mii->val_out);
        }
    }
    else if(argc == 5)
    {
        mii->val_in = (uint16_t)strtoul(argv[4], NULL, 16);
        if(ioctl(sockfd, SIOCSMIIREG, &ifr) < 0) {
            printf("write error:%s\n", strerror(errno));
        }
        else {
            printf("write:id=%d reg=0x%08x value=0x%x\n", mii->phy_id, mii->reg_num, mii->val_in);
        }
    }else{
        printf("mdio ethX phyId reg value\n");
    }
    if(sockfd > 0) {
        close(sockfd);
    }

    return 0;
}
