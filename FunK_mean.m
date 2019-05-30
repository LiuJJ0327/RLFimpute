function [resX,resY,record ] = FunK_mean( x,y,k )
% ���ܣ�
%     ʵ��k-mean�����㷨
% ���룺
%     ��ά���ݣ��ֱ���x,y����һά������������ά��
%     k �Ƿֳɵ���������
% �����
%     k�е���������
%     ��Ӧͬ���ĵ�n�У�����ŵ�n�������Ԫ��
%     record: ��¼��ÿһ�е���ЧԪ�صĸ���

    %j = 1;
    % ������Ԥ����һЩ�ռ�
    % seedX �� seedY �д������������
    seedX = zeros(1,k);
    seedY = zeros(1,k);
    %oldSeedX = zeros(1,k);
    %oldSeedY = zeros(1,k);
    resX = zeros(k,length(x));
    resY = zeros(k,length(x));
    % ������¼resX��ÿһ����ЧԪ�صĸ���
    record = zeros(1,k); 
    center=zeros(k,2);
    
%     totaldata=[x,y];
%     for x=1:k
%         center(x,:)=totaldata( randi(300,1),:);%��һ�����������������
%     end
%     seedX=center(:,1);
%     seedY=center(:,2);

%     seedX = x(randperm(length(x),k));
%     seedY = y(randperm(length(x),k));

    for i = 1:k % ����k���������, ע�⣺ �������������Ԫ�ؼ���
%         seedX(i) = x(round(rand()*length(resX)));
%         seedY(i) = y(round(rand()*length(resX)));
          %seedid=randi(length(x),1);
          seedX(i) = x(randi(length(x),1));
          seedY(i) = y(randi(length(x),1));
        % Ϊ��֤���Ӳ��ص�
        if (i > 1 && seedX(i) == seedX(i-1) && seedY(i) == seedY(i-1))
            i = i -1; % ���²���һ������
        end
    end


%     [seedX,seedY] = setseed(x,y,resX,k);

    %seedX;
    %seedY;
    while 1
        %disp(['jack is here']);
        record(:) = 0; % ����Ϊ��
        resX(:) = 0;
        resY(:) = 0;
        for i = 1:length(x) % ������Ԫ�ر���
            % �������жϱ���Ԫ��Ӧ�ù�Ϊ��һ�࣬���������Ǹ���ŷ����þ����������ж�
            % k-mean�㷨��ΪԪ��Ӧ�ù�Ϊ������������Ӵ������
            distanceMin = 1;
            for j = 2:k
                if (power(x(i)-seedX(distanceMin),2)+power(y(i)-seedY(distanceMin),2))... 
                    > (power(x(i)-seedX(j),2) + power(y(i)-seedY(j),2))
                    distanceMin = j;
                end
            end
            % ������Ԫ�ص�������鲢
            resX(distanceMin,record(distanceMin)+1) = x(i);
            resY(distanceMin,record(distanceMin)+1) = y(i);
            record(distanceMin) = record(distanceMin) + 1;
        end
        oldSeedX = seedX;
        oldSeedY = seedY;
        % �ƶ���������������
        %record;
        for i = 1:k
            if record(i) == 0
                continue;
            end
            seedX(i) = sum(resX(i,:))/record(i);
            seedY(i) = sum(resY(i,:))/record(i);
        end

        % ������εõ������Ӻ��ϴε�����һ�£�����Ϊ������ϡ�

        if mean([seedX == oldSeedX seedY == oldSeedY]) == 1 % ��仰���������˼���� if seedX == oldSeedX && seedY == oldSeedY
            break;
        end
    end
end

