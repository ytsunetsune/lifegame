# -*- coding: utf-8 -*-

import random
import time
import sys

width = 35
height = 35

class lifegame():
    def __init__(self):
        random.seed()
        self.epoch = 0
        self.init_field()
        self.show_field()

    def init_field(self):
        self.field = [[round(random.random() * 0.7) for j in range(width)] for i in range(height)]

    def show_field(self):
        print("epoch: " + str(self.epoch))
        for i in range(height):
            for j in range(width):
                if self.field[i][j] == 1:
                    print("■ ", end='')
                else:
                    print("□ ", end='')
            print("")
        print("")

    def next_step(self):
        for i in range(height):
            for j in range(width):
                tmp = 0

                # ここから周囲の状況を計算
                if i != 0 and j != 0:
                    tmp += self.field[i - 1][j - 1]
                if i != 0 and j != width - 1:
                    tmp += self.field[i - 1][j + 1]
                if i != 0:
                    tmp += self.field[i - 1][j]
                if i != height - 1 and j != 0:
                    tmp += self.field[i + 1][j - 1]
                if i != height - 1 and j != width - 1:
                    tmp += self.field[i + 1][j + 1]
                if i != height - 1:
                    tmp += self.field[i + 1][j]
                if j != 0:
                    tmp += self.field[i][j - 1]
                if j != width - 1:
                    tmp += self.field[i][j + 1]

                # 注目しているセルの進退
                if self.field[i][j] == 0:
                    if tmp == 3:
                        self.field[i][j] = 1
                else:
                    if tmp <= 1 or tmp >= 4:
                        self.field[i][j] = 0

        # カウンタをインクリメント
        self.epoch += 1

if __name__ == '__main__':
    lifegame = lifegame()
    for i in range(2000):
        lifegame.next_step()
        lifegame.show_field()
        time.sleep(1)

