//
//  main.cpp
//  OpenGL
//
//  Created by lee on 2018/8/1.
//  Copyright © 2018年 mjsfax. All rights reserved.
//

#include "stdio.h"

/*移入了GLTool着色器管理器(shader manager)类，没有着色器，就不能着色*/
#include "GLShaderManager.h"
/*包含大部分GLTool中类似c语言独立函数*/
#include "GLTools.h"
#include "glut/glut.h"

//简单的批次容器，是GLTools的一个简单容器类
GLBatch triangleBatch;
//定义一个着色器
GLShaderManager shaderManager;
//窗口大小改变时接受新的宽度和高度，其中0,0代表窗口中视口的左下角坐标，w，h代表像素
void ChangeSize(int w,int h) {
    glViewport(0,0, w, h);
    
}
//为程序作一次性的设置
void SetupRC() {
    //设置背影颜色
    glClearColor(0.0f,1.0f,0.0f,1.0f);
    //初始化着色管理器
    shaderManager.InitializeStockShaders();
    //设置三角形，其中数组vVert包含所有3个顶点的x,y,笛卡尔坐标对。
    GLfloat vVerts[] = { -0.5f,0.0f,0.0f, 0.5f,0.0f,0.0f, 0.0f,0.5f,0.0f, };
    //批次处理 3:三个顶点
    triangleBatch.Begin(GL_TRIANGLES,3);
    triangleBatch.CopyVertexData3f(vVerts);
    triangleBatch.End();
    
}
//开始渲染
void RenderScene(void) {
    //清除一个或一组特定的缓冲区
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT|GL_STENCIL_BUFFER_BIT);
    //设置一组浮点数来表示红色
    GLfloat vRed[] = {1.0f,0.0f,0.0f,1.0f};
    //传递到存储着色器，即GLT_SHADER_IDENTITY着色器，这个着色器只是使用指定颜色以默认笛卡尔坐标第在屏幕上渲染几何图形
    shaderManager.UseStockShader(GLT_SHADER_IDENTITY,vRed);
    //提交着色器
    triangleBatch.Draw();
    //将在后台缓冲区进行渲染，然后在结束时交换到前台
    glutSwapBuffers();
    
}

int main(int argc,char* argv[]) {
    //设置当前工作目录，针对MAC OS X
    gltSetWorkingDirectory(argv[0]);
    //初始化GLUT库
    glutInit(&argc, argv);
    /*初始化双缓冲窗口，其中标志GLUT_DOUBLE、GLUT_RGBA、GLUT_DEPTH、GLUT_STENCIL分别指 双缓冲窗口、RGBA颜色模式、深度测试、模板缓冲区*/
    glutInitDisplayMode(GLUT_DOUBLE|GLUT_RGBA|GLUT_DEPTH|GLUT_STENCIL);
    //GLUT窗口大小，标题窗口
    glutInitWindowSize(800,600);
    glutCreateWindow("Triangle");
    
    /*GLUT内部运行一个本地消息循环，拦截适当的消息。然后调用我们不同时间注册的回调函数
     一共注册2个回调函数：1 窗口改变大小回调函数 2 opengl渲染回调函数
     */
    
    //注册回调函数
    glutReshapeFunc(ChangeSize);
    //注册显示函数
    glutDisplayFunc(RenderScene);
    //驱动程序的初始化中没有出现任何问题。
    /*初始化一个glew库，确保opengl api对程序完全可用
     在试图做任何渲染之前，检查确定驱动程序的初始化过程没有任何问题*/
    GLenum err = glewInit();
    if(GLEW_OK != err) {
        fprintf(stderr,"glew error:%s\n",glewGetErrorString(err));
        return 1;
    }
    //调用SetupRC 设置渲染环境
    SetupRC();
    glutMainLoop();
    return 0;
    
}
