# What is howlines?

해당 디렉터리 내에 얼마나 많은 코드파일이 있는지 확인해보기 위해 만든 간단한 애플리캐이션입니다  
윈도우 64 비트의 경우 그냥 이 저장소 안에 있는 howlines.exe 를 복사해 사용하면 됩니다  

# How to build howlines?

1. luvi 를 설치 하세요  
[luvi](https://github.com/luvit/luvi) 를 설치 한 후 (path 처리가 되어 있는 적합한 디렉터리에 배치한 후)  
이 리포를 클론합니다  
```sh
git clone https://github.com/qwreey75/howlines.git
cd howlines
```
그런 후 간단히  
```sh
luvi app -o howlines(.exe 또는 .o 등등.. 시스템에 맞게 입력하세요)
```
를 입력하면 빌드된 바이너리 파일이 나타납니다  

# How to use?

간단히 적합한 디렉터리에 howlines 를 집어넣어 놓은 상태로, 몇줄이 있는지 확인하고 싶은 디렉터리로 이동합니다  
그런 후 다음과 같이 입력합니다  
```sh
howlines
```
만약, 특별한 디렉터리를 스캔하려면  
```sh
howlines ./app
```
과 같은 방식으로 사용할 수 있습니다  
