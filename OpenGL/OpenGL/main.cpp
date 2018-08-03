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

//正方形边长一半
GLfloat blockSize = 0.1f;
//正方形定点定义
GLfloat vVerts[] = {
    -blockSize, -blockSize, 0.0f,
    blockSize, -blockSize, 0.0f,
    blockSize, blockSize, 0.0f,
    -blockSize, blockSize, 0.0f
};

//x轴移动距离
GLfloat xPos = 0.0f;
//y轴移动距离
GLfloat yPos = 0.0f;

//窗口大小改变时接受新的宽度和高度，其中0,0代表窗口中视口的左下角坐标，w，h代表像素
void ChangeSize(int w,int h) {
    glViewport(0,0, w, h);
}

#pragma mark - 平移
//移动图形--修改定点坐标
void SpeacialKeys(int key, int x, int y) {
    //步长
    GLfloat stepSize = 0.025f;
    /*xpos ypos 利用矩阵实现*/
//    GLfloat blockX = vVerts[0];
//    GLfloat blockY = vVerts[10];
    if (key == GLUT_KEY_UP) {
//        blockY += stepSize;
        yPos += stepSize;
    } else if (key == GLUT_KEY_DOWN) {
//        blockY -= stepSize;
        yPos -= stepSize;
    } else if (key == GLUT_KEY_LEFT) {
//        blockX -= stepSize;
        xPos -= stepSize;
    } else if (key == GLUT_KEY_RIGHT) {
//        blockX += stepSize;
        xPos += stepSize;
    } else {
        printf("方向错误");
        return;
    }
    
    if (xPos < -1.0f + blockSize) {
        xPos = -1.0f + blockSize;
    }
    if (xPos > 1.0f - blockSize) {
        xPos = 1.0f - blockSize;
    }
    if (yPos < -1.0f + blockSize) {
        yPos = -1.0f + blockSize;
    }
    if (yPos > 1.0f - blockSize) {
        yPos = 1.0f - blockSize;
    }
    
/*
    if (blockX<-1.0f) {
        blockX = -1.0f;
    }
    if (blockX>1.0f-2*blockSize) {
        blockX = 1.0f-2*blockSize;
    }
    if (blockY<-1.0f+2*blockSize) {
        blockY = -1.0f+2*blockSize;
    }
    if (blockY > 1.0f) {
        blockY = 1.0f;
    }
    
    //根据d点计算其他点
    //d
    vVerts[9] = blockX;
    vVerts[10] = blockY;
    //a
    vVerts[0] = blockX;
    vVerts[1] = blockY - 2*blockSize;
    //b
    vVerts[3] = blockX + 2*blockSize;
    vVerts[4] = blockY - 2*blockSize;
    //c
    vVerts[6] = blockX + 2*blockSize;
    vVerts[7] = blockY;
*/
    //移动
    triangleBatch.CopyVertexData3f(vVerts);
    glutPostRedisplay();
}

#pragma mark - 画圆形
void draw() {
    //1清屏颜色
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    //开始渲染
    glBegin(GL_POLYGON);
    const int n = 55;
    const float R = 0.5f;
    const GLfloat PI = 3.1415926f;
    for (int i=0; i<n; i++) {
        glVertex2f(R * cos(2 * PI / n * i), R * sin(2 * PI / n * i));
    }
    //结束渲染
    glEnd();
    
    glFlush();
    
}

//为程序作一次性的设置
void SetupRC() {
    //设置背影颜色
    glClearColor(1.0f,1.0f,1.0f,1.0f);
    //初始化着色管理器
    //初始化固定管线
    shaderManager.InitializeStockShaders();
    //设置三角形，其中数组vVert包含所有3个顶点的x,y,笛卡尔坐标对。
//    GLfloat vVerts[] = { -0.5f,0.0f,0.0f, 0.5f,0.0f,0.0f, 0.0f,0.5f,0.0f, };
    //批次处理 3:三个顶点
    //GL_TRIANGLES三角形
    triangleBatch.Begin(GL_TRIANGLE_FAN,4);
    triangleBatch.CopyVertexData3f(vVerts);
    triangleBatch.End();
    
}

//开始渲染
void RenderScene(void) {
    //清除一个或一组特定的缓冲区
    //清除屏幕颜色
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT|GL_STENCIL_BUFFER_BIT);
    //设置一组浮点数来表示红色
    GLfloat vRed[] = {1.0f,0.0f,0.0f,1.0f};
    //传递到存储着色器，即GLT_SHADER_IDENTITY着色器，这个着色器只是使用指定颜色以默认笛卡尔坐标第在屏幕上渲染几何图形
    //单元着色器
//    shaderManager.UseStockShader(GLT_SHADER_IDENTITY,vRed);
    
    //利用矩阵移动
    //mFinalTransform结果矩阵 mTransformMatrix平移矩阵 mRotationMatrix旋转矩阵
    M3DMatrix44f mFinalTransform, mTransformMatrix, mRotationMatrix;
    
    //平移 3d中平移的原理与矩阵之间关系 x y z w(缩放因子)
    /*参数1：矩阵 参数2 3 4:x、y、z上平移距离*/
    m3dTranslationMatrix44(mTransformMatrix, xPos, yPos, 0.0f);
    
    //一边移动 一边旋转
    static float yRot = 0.0f;
  
    /*参数：1矩阵  2 弧度 3 x 围绕x轴旋转1、不旋转0 4 y旋转  5 z旋转*/
    m3dRotationMatrix44(mRotationMatrix, m3dDegToRad(yRot), 0.0f, 0.0f, 1.0f);
    //修改旋转度数
    yRot += 5.0f;
    m3dMatrixMultiply44(mFinalTransform, mTransformMatrix, mRotationMatrix);
    //平面着色器
    shaderManager.UseStockShader(GLT_SHADER_FLAT, mFinalTransform, vRed);
    
    //提交着色器
    triangleBatch.Draw();
    //将在后台缓冲区进行渲染，然后在结束时交换到前台
    glutSwapBuffers();
    
}

int main(int argc,char* argv[]) {
    //设置当前工作目录，针对MAC OS X
//    gltSetWorkingDirectory(argv[0]);
    //初始化GLUT库
    glutInit(&argc, argv);
    /*初始化双缓冲窗口，其中标志GLUT_DOUBLE、GLUT_RGBA、GLUT_DEPTH、GLUT_STENCIL分别指 双缓冲窗口、RGBA颜色模式、深度测试、模板缓冲区*/
//    glutInitDisplayMode(GLUT_DOUBLE|GLUT_RGBA|GLUT_DEPTH|GLUT_STENCIL);
    //GLUT窗口大小，标题窗口
    glutInitWindowSize(800,600);
    glutCreateWindow("Triangle");
    
    /*GLUT内部运行一个本地消息循环，拦截适当的消息。然后调用我们不同时间注册的回调函数
     一共注册2个回调函数：1 窗口改变大小回调函数 2 opengl渲染回调函数
     */
    
    //注册回调函数
//    glutReshapeFunc(ChangeSize);
    //注册显示函数
    glutDisplayFunc(draw);//RenderScene
    //键盘回调
//    glutSpecialFunc(SpeacialKeys);
    
    //驱动程序的初始化中没有出现任何问题。
    /*初始化一个glew库，确保opengl api对程序完全可用
     在试图做任何渲染之前，检查确定驱动程序的初始化过程没有任何问题*/
//    GLenum err = glewInit();
//    if(GLEW_OK != err) {
//        fprintf(stderr,"glew error:%s\n",glewGetErrorString(err));
//        return 1;
//    }
    //调用SetupRC 设置渲染环境
//    SetupRC();
    glutMainLoop();
    return 0;
    
}
