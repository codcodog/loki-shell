loki shell
===========

### 场景

在 A 电脑 `terminal` 使用 `ctrl + r` 输入历史命令，希望在 B 电脑 `ctrl + r` 的时候也能输入 A 电脑的历史命令，反之亦然.

搭建一个中心化历史命令，在任何客户端电脑 `ctrl + r` 的时候都能补全曾经在 `terminal` 输入过的历史命令.


### 依赖

- loki
- promtail
- logcli
- fzf

> loki 是主服务器，负责存储日志和处理查询.  
> promtail 是代理，负责收集日志并将其发送给 loki.


### 安装

在 `server` 端，安装 `loki`.

```bash
$ curl -O -L "https://github.com/grafana/loki/releases/download/v2.3.0/loki-linux-amd64.zip"

$ unzip "loki-linux-amd64.zip"

$ mv loki-linux-amd64 loki
```

运行 `loki`
```bash
$ nohup ./loki -config.file=loki-config.yaml > error.log 2>&1 &
```


在 `client` 端，安装 `promtail`
```bash
$ curl -O -L "https://github.com/grafana/loki/releases/download/v2.4.0/promtail-linux-amd64.zip"

$ unzip "promtail-linux-amd64.zip"

$ mv promtail-linux-amd64 promtail
```

运行 `promtail`
```bash
$ nohup ./promtail -config.file=promtail-config.yaml > error.log 2>&1 &
```

`client` 端还需要安装 `fzf` 和 `logcli`，这里不赘述，见参考.


最后，在 `terminal` 使用，加载 `bash` 配置即可.
```bash
$ source loki-shell.bash
```


### 参考

[loki](https://grafana.com/docs/loki/latest/installation/)  
[fzf](https://github.com/junegunn/fzf#installation)  
[logcli](https://grafana.com/docs/loki/latest/getting-started/logcli/)  
[Level up your shell history with Loki and fzf](https://opensource.com/article/20/10/shell-history-loki-fzf)
