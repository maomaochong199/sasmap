@echo off
chcp 65001

setlocal enabledelayedexpansion

:: 设置要推送的文件夹路径
set folder_path=.

:: 设置远程名和分支名
set remote_name=origin
set branch_name=master

:: 进入文件夹目录
cd %folder_path%

:: 检查Git是否安装
git version > nul 2>&1
if ERRORLEVEL 9009 (
    echo 错误：未检测到Git
    start "" "https://git-scm.com/downloads"
    exit /b 1
)

:: 检查是否处于Git仓库中
if not exist ".git\" (
    echo 错误：这不是一个Git仓库
    exit /b 1
)

:: 添加所有更改
git add .

:: 创建一个提交
set /p commit_message="请输入提交信息: "
git commit -m "!commit_message!"

:: 推送到远程仓库
git push %remote_name% %branch_name%

if ERRORLEVEL 1 (
    echo 错误：推送到远程仓库失败
    exit /b 1
)

echo 成功推送到远程仓库！
exit /b 0