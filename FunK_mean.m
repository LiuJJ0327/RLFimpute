function [resX,resY,record ] = FunK_mean( x,y,k )
% 功能：
%     实现k-mean聚类算法
% 输入：
%     二维数据，分别用x,y两个一维向量代表两个维度
%     k 是分成的类别的数量
% 输出：
%     k行的两个矩阵
%     对应同样的第n行，存放着第n类的所有元素
%     record: 记录着每一行的有效元素的个数

    %j = 1;
    % 下面是预分配一些空间
    % seedX 和 seedY 中存放着所有种子
    seedX = zeros(1,k);
    seedY = zeros(1,k);
    %oldSeedX = zeros(1,k);
    %oldSeedY = zeros(1,k);
    resX = zeros(k,length(x));
    resY = zeros(k,length(x));
    % 用来记录resX中每一行有效元素的个数
    record = zeros(1,k); 
    center=zeros(k,2);
    
%     totaldata=[x,y];
%     for x=1:k
%         center(x,:)=totaldata( randi(300,1),:);%第一次随机产生聚类中心
%     end
%     seedX=center(:,1);
%     seedY=center(:,2);

%     seedX = x(randperm(length(x),k));
%     seedY = y(randperm(length(x),k));

    for i = 1:k % 产生k个随机种子, 注意： 随机种子是来自元素集合
%         seedX(i) = x(round(rand()*length(resX)));
%         seedY(i) = y(round(rand()*length(resX)));
          %seedid=randi(length(x),1);
          seedX(i) = x(randi(length(x),1));
          seedY(i) = y(randi(length(x),1));
        % 为保证种子不重叠
        if (i > 1 && seedX(i) == seedX(i-1) && seedY(i) == seedY(i-1))
            i = i -1; % 重新产生一个种子
        end
    end


%     [seedX,seedY] = setseed(x,y,resX,k);

    %seedX;
    %seedY;
    while 1
        %disp(['jack is here']);
        record(:) = 0; % 重置为零
        resX(:) = 0;
        resY(:) = 0;
        for i = 1:length(x) % 对所有元素遍历
            % 下面是判断本次元素应该归为哪一类，这里我们是根据欧几里得距离进行类别判定
            % k-mean算法认为元素应该归为距离最近的种子代表的类
            distanceMin = 1;
            for j = 2:k
                if (power(x(i)-seedX(distanceMin),2)+power(y(i)-seedY(distanceMin),2))... 
                    > (power(x(i)-seedX(j),2) + power(y(i)-seedY(j),2))
                    distanceMin = j;
                end
            end
            % 将本次元素点进行类别归并
            resX(distanceMin,record(distanceMin)+1) = x(i);
            resY(distanceMin,record(distanceMin)+1) = y(i);
            record(distanceMin) = record(distanceMin) + 1;
        end
        oldSeedX = seedX;
        oldSeedY = seedY;
        % 移动种子至其类中心
        %record;
        for i = 1:k
            if record(i) == 0
                continue;
            end
            seedX(i) = sum(resX(i,:))/record(i);
            seedY(i) = sum(resY(i,:))/record(i);
        end

        % 如果本次得到的种子和上次的种子一致，则认为分类完毕。

        if mean([seedX == oldSeedX seedY == oldSeedY]) == 1 % 这句话所想表达的意思就是 if seedX == oldSeedX && seedY == oldSeedY
            break;
        end
    end
end

