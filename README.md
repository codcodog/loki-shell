loki shell
===========

### 场景

在 A 电脑 `terminal` 使用 `ctrl + r` 输入历史命令，希望在 B 电脑 `ctrl + r` 的时候也能输入 A 电脑的历史命令，反之亦然.

搭建一个中心化历史命令，在任何客户端电脑 `ctrl + r` 的时候都能补全曾经在 `terminal` 输入过的历史命令.


### 依赖

- fzf
- loki
- promtail
- logcli

> loki是主服务器，负责存储日志和处理查询.  
> promtail是代理，负责收集日志并将其发送给 loki.


### 安装

在 `server` 端，安装 `loki`.

```bash
$ curl -O -L "https://github.com/grafana/loki/releases/download/v2.3.0/loki-linux-amd64.zip"

$ unzip "loki-linux-amd64.zip"

$ chmod a+x "loki-linux-amd64"
```




### 参考

[Loki](https://grafana.com/docs/loki/latest/installation/)  
[Level up your shell history with Loki and fzf](https://opensource.com/article/20/10/shell-history-loki-fzf)
