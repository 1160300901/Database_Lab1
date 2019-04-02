# -*- coding: utf-8 -*-
'''
@author: xinghuazhang
@license: (C) Copyright 2013-2017, Node Supply Chain Manager Corporation Limited.
@contact: xing_hua_zhang@126.com
@software: PyCharm 2017.1.4
@file: lab3.py
@time: 2018/5/5 0:39
@desc:
'''
import sys
from PyQt4.QtGui import *
from PyQt4.QtCore import *
import MySQLdb


# reload(sys)
# sys.setdefaultencoding("utf-8")


class MainWindow(QWidget):
    """
    PyQt main window
    """

    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)

        self.setWindowTitle('公司数据库系统')
        self.setWindowIcon(QIcon('icon.gif'))

        main_splitter = QSplitter(Qt.Horizontal)  # 水平分割
        main_splitter.setOpaqueResize(True)  # 设定在拖拽分割条时，是否实时更新

        frame = QFrame(main_splitter)  # 基本控件的基类
        stack = QStackedWidget()  # 一个堆栈窗口控件，可以填充一些小控件，但是同一时间只有一个小控件可以显示
        stack.setFrameStyle(QFrame.Panel | QFrame.Raised)

        insert = Insert()  # 插入
        delete = Delete()  # 删除
        view = View()  # 视图
        query = Query()  # 查询
        transaction = Transaction()  # 事务
        trigger = Trigger()  # 触发器
        # 在QStackedWidget对象中填充了六个子控件
        stack.addWidget(insert)
        stack.addWidget(delete)
        stack.addWidget(view)
        stack.addWidget(query)
        stack.addWidget(transaction)
        stack.addWidget(trigger)
        # 采用QVBoxLayout类，按照从上到下的顺序添加控件
        main_layout = QVBoxLayout(frame)
        main_layout.setMargin(10)  # 表示控件与窗体的左右边距
        main_layout.setSpacing(6)  # 表示各个控件之间的上下间距
        main_layout.addWidget(stack)

        # 创建列表窗口，添加条目
        list_widget = QListWidget(main_splitter)
        # 第一个参数是字体（微软雅黑），第二个是字体大小，第三个是加粗（50代表正常）
        list_widget.setFont(QFont("SimSun", 12, 50))
        list_widget.insertItem(1, self.tr("插入"))
        list_widget.insertItem(2, self.tr("删除"))
        list_widget.insertItem(3, self.tr("视图查询"))
        list_widget.insertItem(4, self.tr("表查询"))
        list_widget.insertItem(5, self.tr("事务处理"))
        list_widget.insertItem(6, self.tr("触发器"))
        # sender=list_widget,receiver=stack
        self.connect(list_widget, SIGNAL("currentRowChanged(int)"), stack, SLOT("setCurrentIndex(int)"))

        layout = QHBoxLayout(self)  # 水平布局
        layout.addWidget(main_splitter)
        self.setLayout(layout)
        self.show()
        self.resize(1000, 600)

    # if close dialog window
    def closeEvent(self, event):
        reply = QMessageBox.question(self, 'Warning',
                                     "Are you sure to quit?", QMessageBox.Yes, QMessageBox.No)

        if reply == QMessageBox.Yes:
            event.accept()
        else:
            event.ignore()


class Insert(QWidget):
    """
    insert into table values
    """

    def __init__(self, parent=None):
        super(Insert, self).__init__(parent)

        label1 = QLabel(self.tr("表名"))
        label2 = QLabel(self.tr("值"))
        button = QPushButton(self.tr("插入"))
        d_button = QPushButton(self.tr(">>详细>>"))
        label3 = QLabel(self.tr("结果"))
        label1.setFont(QFont("SimSun", 12))
        label2.setFont(QFont("SimSun", 12))
        button.setFont(QFont("SimSun", 12))
        d_button.setFont(QFont("SimSun", 12))
        label3.setFont(QFont("SimSun", 12))
        self.tableEdit = QLineEdit()
        self.attrEdit = QLineEdit()
        self.resultEdit = QTextEdit()
        self.tableEdit.setFont(QFont("Times New Roman", 11))
        self.attrEdit.setFont(QFont("Times New Roman", 11))
        self.resultEdit.setFont(QFont("Times New Roman", 10))
        layout = QGridLayout(self)
        layout.addWidget(label1, 0, 0)
        layout.addWidget(self.tableEdit, 0, 1)
        layout.addWidget(label2, 1, 0)
        layout.addWidget(self.attrEdit, 1, 1)
        layout.addWidget(button, 2, 0)
        layout.addWidget(d_button, 2, 1)
        layout.addWidget(label3, 3, 0)
        layout.addWidget(self.resultEdit, 3, 1)
        # 按钮点击事件
        self.connect(button, SIGNAL("clicked()"), self.excute)
        self.connect(d_button, SIGNAL("clicked()"), self.desc)

    def desc(self):
        """
        before inserting into values, check attribute of table
        :return: None
        """
        try:
            table = self.tableEdit.text()
            ss = "desc " + str(table)
            desc = cur.fetchmany(cur.execute(ss))
            print(desc)
            sq = "Field\tType\tNull\tkey\tDefault\tExtra\n"
            sq += "----------------------------------------------------------------------------------\n"
            for k in desc:
                for attr in k:
                    if attr == None:
                        attr = 'NULL'
                    if attr == u'':
                        attr = '空'
                    sq += attr + '\t'
                sq += '\n'
            self.resultEdit.setText(sq)
        except(BaseException) as e:
            print(e)
            msg_box = QMessageBox(QMessageBox.Warning, ">_<", "遇到一个错误，正在努力解决ing... =.=")
            msg_box.exec_()

    def excute(self):
        """
        execute insert function
        :return: None
        """
        try:
            table = self.tableEdit.text()
            value = self.attrEdit.text()
            value = str(value).split()
            print(value)
            ss = "desc " + str(table)
            desc = cur.fetchmany(cur.execute(ss))
            sq = ""
            for tt in range(len(desc) - 1):
                if 'varchar' in desc[tt][1]:
                    sq += "'" + str(value[tt]) + "',"
                else:
                    sq += value[tt] + ','
            if 'varchar' in desc[len(desc) - 1][1]:
                sq += "'" + str(value[len(desc) - 1]) + "'"
            else:
                sq += value[len(desc) - 1]
            sql_str = "insert into " + str(table) + " values(" + sq + ")"
            print(sql_str)
            cur.execute(sql_str)
            conn.commit()
            self.resultEdit.setText("~插入成功~")
        except(BaseException) as e:
            print(e)
            msg_box = QMessageBox(QMessageBox.Warning, ">_<", "=.= 插入失败 =.=")
            msg_box.exec_()


class Delete(QWidget):
    """
    delete record in some table
    """

    def __init__(self, parent=None):
        super(Delete, self).__init__(parent)

        label1 = QLabel(self.tr("表名"))
        label3 = QLabel(self.tr("条件"))
        button = QPushButton(self.tr("删除"))
        label4 = QLabel(self.tr("结果"))
        label1.setFont(QFont("隶书", 13))
        label3.setFont(QFont("隶书", 13))
        label4.setFont(QFont("隶书", 13))
        button.setFont(QFont("隶书", 13))
        self.tableEdit = QLineEdit()
        self.limitEdit = QLineEdit()
        self.resultEdit = QTextEdit()
        self.tableEdit.setFont(QFont("Times New Roman", 11))
        self.limitEdit.setFont(QFont("Times New Roman", 11))
        self.resultEdit.setFont(QFont("Times New Roman", 10))
        layout = QGridLayout(self)
        layout.addWidget(label1, 0, 0)
        layout.addWidget(self.tableEdit, 0, 1)
        layout.addWidget(label3, 1, 0)
        layout.addWidget(self.limitEdit, 1, 1)
        layout.addWidget(button, 2, 0)
        layout.addWidget(label4, 3, 0)
        layout.addWidget(self.resultEdit, 3, 1)
        self.connect(button, SIGNAL("clicked()"), self.excute)

    def excute(self):
        """
        execute delete function
        :return: None
        """
        try:
            table = self.tableEdit.text()
            # attr = self.attrEdit.text()
            limit = self.limitEdit.text()
            sql_str = "delete from " + table
            if len(limit) > 0:
                sql_str += " where " + limit
            print(sql_str)
            cur.execute(str(sql_str))  # .decode("gbk").encode("utf8")
            conn.commit()
            self.resultEdit.setText("删除成功~")
        except(BaseException) as e:
            msg_box = QMessageBox(QMessageBox.Warning, ">_<", "=.= 删除失败 =.=")
            msg_box.exec_()


class Query(QWidget):
    """
    select something from table expected
    """

    def __init__(self, parent=None):
        super(Query, self).__init__(parent)

        label1 = QLabel(self.tr("表名"))
        label2 = QLabel(self.tr("查询属性"))
        label3 = QLabel(self.tr("条件"))
        label4 = QLabel(self.tr("分组"))
        button = QPushButton(self.tr("查询"))
        label5 = QLabel(self.tr("结果"))
        label1.setFont(QFont("隶书", 13))
        label2.setFont(QFont("隶书", 13))
        label3.setFont(QFont("隶书", 13))
        label4.setFont(QFont("隶书", 13))
        button.setFont(QFont("隶书", 13))
        label5.setFont(QFont("隶书", 13))
        self.tableEdit = QLineEdit()
        self.attrEdit = QLineEdit()
        self.limitEdit = QLineEdit()
        self.groupEdit = QLineEdit()
        self.resultEdit = QTextEdit()
        self.tableEdit.setFont(QFont("Times New Roman", 11))
        self.attrEdit.setFont(QFont("Times New Roman", 11))
        self.limitEdit.setFont(QFont("Times New Roman", 11))
        self.groupEdit.setFont(QFont("Times New Roman", 11))
        self.resultEdit.setFont(QFont("Times New Roman", 10))
        layout = QGridLayout(self)
        layout.addWidget(label1, 0, 0)
        layout.addWidget(self.tableEdit, 0, 1)
        layout.addWidget(label2, 1, 0)
        layout.addWidget(self.attrEdit, 1, 1)
        layout.addWidget(label3, 2, 0)
        layout.addWidget(self.limitEdit, 2, 1)
        layout.addWidget(label4, 3, 0)
        layout.addWidget(self.groupEdit, 3, 1)
        layout.addWidget(button, 4, 0)
        layout.addWidget(label5, 5, 0)
        layout.addWidget(self.resultEdit, 5, 1)
        self.connect(button, SIGNAL("clicked()"), self.excute)

    def excute(self):
        """
        execute select function
        :return: None
        """
        try:
            table = self.tableEdit.text()
            attr = self.attrEdit.text()
            query = "select " + attr + " from " + table
            limit = self.limitEdit.text()
            if len(limit) > 0:
                query += " where " + limit
            group = self.groupEdit.text()
            if len(group) > 0:
                query += " group by " + group
            print(query)
            sql_result = cur.execute(str(query)) # .decode("gbk").encode("utf8")
            info = cur.fetchmany(sql_result)
            result = ""
            for i in info:
                for j in i:
                    result += "\t"
                    result += str(j)
                result += '\n'
            if len(result) > 0:
                self.resultEdit.setText(result)
            else:
                self.resultEdit.setText("查询失败=.=")
        except(BaseException) as e:
            print(e)
            msg_box = QMessageBox(QMessageBox.Warning, ">_<", "查询失败 =.=")
            msg_box.exec_()


class View(QWidget):
    """
    view query
    """

    def __init__(self, parent=None):
        super(View, self).__init__(parent)

        label1 = QLabel(self.tr("视图名"))
        label2 = QLabel(self.tr("查询属性"))
        label3 = QLabel(self.tr("条件"))
        button = QPushButton(self.tr("查询"))
        label4 = QLabel(self.tr("结果"))
        label1.setFont(QFont("隶书", 13))
        label2.setFont(QFont("隶书", 13))
        label3.setFont(QFont("隶书", 13))
        label4.setFont(QFont("隶书", 13))
        button.setFont(QFont("隶书", 13))
        self.viewEdit = QLineEdit()
        self.attrEdit = QLineEdit()
        self.limitEdit = QLineEdit()
        self.resultEdit = QTextEdit()
        self.viewEdit.setFont(QFont("Times New Roman", 11))
        self.attrEdit.setFont(QFont("Times New Roman", 11))
        self.limitEdit.setFont(QFont("Times New Roman", 11))
        self.resultEdit.setFont(QFont("Times New Roman", 10))
        layout = QGridLayout(self)
        layout.addWidget(label1, 0, 0)
        layout.addWidget(self.viewEdit, 0, 1)
        layout.addWidget(label2, 1, 0)
        layout.addWidget(self.attrEdit, 1, 1)
        layout.addWidget(label3, 2, 0)
        layout.addWidget(self.limitEdit, 2, 1)
        layout.addWidget(button, 3, 0)
        layout.addWidget(label4, 4, 0)
        layout.addWidget(self.resultEdit, 4, 1)
        self.connect(button, SIGNAL("clicked()"), self.excute)

    def excute(self):
        """
        execute view select
        :return: None
        """
        try:
            view = self.viewEdit.text()
            attr = self.attrEdit.text()
            sql_str = "select " + attr + " from " + view
            limit = self.limitEdit.text()
            if len(str(limit)) > 0:
                sql_str += " where " + limit
            print(sql_str)
            sql_result = cur.execute(str(sql_str))
            info = cur.fetchmany(sql_result)
            result = ""
            for i in info:
                for j in i:
                    result += "\t"
                    result += str(j)
                result += '\n'
            if len(result) > 0:
                self.resultEdit.setText(result)
            else:
                self.resultEdit.setText("无法查询=.=")
        except(BaseException) as e:
            msg_box = QMessageBox(QMessageBox.Warning, ">_<", "=.= 查询失败 =.=")
            msg_box.exec_()


class Transaction(QWidget):
    """
    transaction management
    """

    def __init__(self, parent=None):
        super(Transaction, self).__init__(parent)
        input_button = QPushButton(self.tr("财务员将相关信息录入系统：\n某某因XXX交罚款XXX元"))
        label1 = QLabel(self.tr("****等到交钱时，该员工搜罗兜里的所有钱，\n500、600、750...>_<*****"))
        commit_button = QPushButton(self.tr("不多不少，正好够交罚款..."))
        roll_back_button = QPushButton(self.tr("兜里钱不够...>_<"))
        label2 = QLabel(self.tr("****某员工到财务处交罚金>_<*****"))
        label3 = QLabel(self.tr("****财务员询问相关信息\n(你的职工号是什么？\n违反了公司的第几条规定？)：*****"))
        input_button.setFont(QFont("隶书", 13))
        label1.setFont(QFont("隶书", 13))
        commit_button.setFont(QFont("隶书", 13))
        roll_back_button.setFont(QFont("隶书", 13))
        label2.setFont(QFont("隶书", 13))
        label3.setFont(QFont("隶书", 13))

        self.essnEdit = QLineEdit()
        self.essnEdit.setMaxLength(5)
        self.rpEdit = QLineEdit()
        self.essnEdit.setFont(QFont("Times New Roman", 11))
        self.rpEdit.setFont(QFont("Times New Roman", 11))

        layout = QGridLayout(self)
        layout.addWidget(label2, 0, 0)
        layout.addWidget(label3, 1, 0)
        layout.addWidget(self.essnEdit, 2, 0)
        layout.addWidget(self.rpEdit, 2, 1)
        layout.addWidget(input_button, 3, 0)
        layout.addWidget(label1, 4, 0)
        layout.addWidget(commit_button, 5, 0)
        layout.addWidget(roll_back_button, 5, 1)
        self.connect(input_button, SIGNAL("clicked()"), self.input)

        self.connect(commit_button, SIGNAL("clicked()"), self.commit)
        self.connect(roll_back_button, SIGNAL("clicked()"), self.roll_back)

    def start(self):
        pass

    def input(self):
        """
        execute
        :return: None
        """
        try:
            essn = self.essnEdit.text()
            rp = self.rpEdit.text()
            sq = "insert into employee_rp values(" + str(essn) + ',' + str(rp) + ")"
            print(sq)
            cur.execute(sq)
        except(BaseException) as e:
            print(e)
            msg_box = QMessageBox(QMessageBox.Warning, ">_<", "发生了一个未知错误，正在努力解决ing... =.=")
            msg_box.exec_()

    def commit(self):
        """
        commit
        :return: None
        """
        conn.commit()

    def roll_back(self):
        """
        roll back
        :return: None
        """
        conn.rollback()


class Trigger(QWidget):
    """
    trigger
    """

    def __init__(self, parent=None):
        super(Trigger, self).__init__(parent)

        label1 = QLabel(self.tr("表名"))
        button1 = QPushButton(self.tr("查询触发器"))
        button2 = QPushButton(self.tr("查询"))
        label5 = QLabel(self.tr("结果"))
        label1.setFont(QFont("隶书", 13))
        button1.setFont(QFont("隶书", 13))
        button2.setFont(QFont("隶书", 13))
        label5.setFont(QFont("隶书", 13))
        self.tableEdit = QLineEdit()
        self.resultEdit = QTextEdit()
        self.tableEdit.setFont(QFont("Times New Roman", 11))
        self.resultEdit.setFont(QFont("Times New Roman", 10))
        layout = QGridLayout(self)
        layout.addWidget(label1, 0, 0)
        layout.addWidget(self.tableEdit, 0, 1)
        layout.addWidget(button1, 1, 0)
        layout.addWidget(button2, 4, 0)
        layout.addWidget(label5, 5, 0)
        layout.addWidget(self.resultEdit, 5, 1)
        self.connect(button1, SIGNAL("clicked()"), self.excute1)
        self.connect(button2, SIGNAL("clicked()"), self.excute2)

    def excute1(self):
        try:
            table = self.tableEdit.text()
            sql = "show triggers like " + "'" + str(table) + "'"
            sql_result = cur.execute(str(sql).decode("gbk").encode("utf8"))
            info = cur.fetchmany(sql_result)
            result_l = ['Trigger', 'Event', 'Table', 'Statement', 'Timing']
            result = ''
            for k in info:
                for i in range(5):
                    if k[i] != None:
                        result += (result_l[i] + ':\t' + k[i] + '\n')
                    else:
                        result += (result_l[i] + ':\t' + 'None' + '\n')
                    result += '-----------------------------------------------------------------\n'
            print(info)
            if len(result) > 0:
                self.resultEdit.setText(result)
            else:
                self.resultEdit.setText("无法查询=.=")
        except(BaseException) as e:
            print(e)
            msg_box = QMessageBox(QMessageBox.Warning, ">_<", "查询触发器失败 =.=")
            msg_box.exec_()

    def excute2(self):
        """
        execute select function
        :return: None
        """
        try:
            query = "select " + '*' + " from " + 'log'
            sql_result = cur.execute(str(query).decode("gbk").encode("utf8"))
            info = cur.fetchmany(sql_result)
            result = ""
            for i in info:
                for j in i:
                    result += "\t"
                    result += str(j)
                result += '\n'
            if len(result) > 0:
                self.resultEdit.setText(result)
            else:
                self.resultEdit.setText("查询失败=.=")
        except(BaseException) as e:
            print(e)
            msg_box = QMessageBox(QMessageBox.Warning, ">_<", "查询失败 =.=")
            msg_box.exec_()


if __name__ == "__main__":
    conn = MySQLdb.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        passwd="123456",
        db="company",
        charset='utf8'
    )
    cur = conn.cursor()

    # 设置传给tr()函数时的默认字符串编码
    # 用在字符串常量或QByteArray构造QString对象时，使用的一种编码方式
    # 用于设置和对本地文件系统读写时候的默认编码格式
    QTextCodec.setCodecForTr(QTextCodec.codecForName("utf8"))
    QTextCodec.setCodecForCStrings(QTextCodec.codecForName("utf8"))
    QTextCodec.setCodecForLocale(QTextCodec.codecForName("utf8"))
    app = QApplication(sys.argv)
    main = MainWindow()
    main.show()
    sys.exit(app.exec_())
    conn.commit()
    cur.close()
    conn.close()
