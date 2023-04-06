function caps_videos_case_control_linux

% this function takes a CAPs analysis and creates the videos



%% 0. LOAD DATA, RESULTS, AND CFC TIMECOURSES. 

clc,clear
k = 6;
study_name = '16p11';
maindir = '/home/safaai/DanielG/caps_analysis/autism_study/16p11';
maindir_caps = [maindir '/runs_woCerebVent_centroids/k_analysis/cap_analysis_k' num2str(k)];
cd(maindir)

% load data
load('mask_info_chd8_lowres')
load('16p11_data_wt_lowres'), data_1 = data; clear data
load('16p11_data_ht_lowres'), data_2 = data; clear data

%normalize data
data_1 = postproc_normalize(data_1);
data_2 = postproc_normalize(data_2);

% name datasets
dsname1 = 'WT';
dsname2 = 'HT';

% load CAP analysis results.
cd([maindir_caps '/caps_dynamics_k' num2str(k)])
load('caps_compare_analysis')
load('caps_compare_analysis_stats')
load('inputs_1')
load('inputs_2')

ord1 = caps_comp_analysis.cap_order_1;
ord2 = caps_comp_analysis.cap_order_2;

% optional, re-do the cpas_evo part

cap_evo_group_percent = 0.1;
cap_evo_group_range = 15;
[evo_group_ds1] = caps_analysis_cap_evo_group(data_1, caps_comp_analysis.cap_CFC_analysis.ds1.CFC_peak_ind(:,ord1), caps_comp_analysis.cap_CFC_analysis.ds1.CFC_peak_amp(:,ord1), caps_comp_analysis.cap_occ.cap_occ_1_mean(ord1),cap_evo_group_range, caps_comp_analysis.cap_CFC_analysis.ds1.CFC(:,ord1), cap_evo_group_percent);
[evo_group_ds2] = caps_analysis_cap_evo_group(data_2, caps_comp_analysis.cap_CFC_analysis.ds2.CFC_peak_ind(:,ord2), caps_comp_analysis.cap_CFC_analysis.ds2.CFC_peak_amp(:,ord2), caps_comp_analysis.cap_occ.cap_occ_2_mean(ord2),cap_evo_group_range, caps_comp_analysis.cap_CFC_analysis.ds2.CFC(:,ord2), cap_evo_group_percent);

for c = 1:k
    evo_group_diff.frames_mean{c} = evo_group_ds2.frames_mean{(c)}-evo_group_ds1.frames_mean{(c)};
end

%create and save the CAP evolution maps.
cd(maindir_caps)

mkdir('CAP_evolution_maps')
cd('CAP_evolution_maps')
caps_analysis_evo_images_linux(evo_group_ds1, mask_info,dsname1);
cd('CAP_evolution_maps')
caps_analysis_evo_images_linux(evo_group_ds2, mask_info,dsname2);
cd('CAP_evolution_maps')
caps_analysis_evo_images_linux(evo_group_diff, mask_info,[dsname2 '-' dsname1]);

end % function