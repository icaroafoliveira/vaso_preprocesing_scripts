## Preprocesing scripts for 7T VASO (SS-SI VASO)
Scripts used to perform motion correction and bold correction for VASO-CBV and BOLD data from the SS-SI VASO scheme.

These scripts are based on SPM12 (Matlab).

- PAR_VASO: Here one can store folders and filenames of all your participants for the VASO-CBV and BOLD datasets.
- MoCo: Perform the SPM12 motion correction (estimate & reslice) both VASO-CBV and BOLD separately and automatically for all participants.
- BoCo: BOLD correction scheme in the VASO-CBV images. BoCo is based on Huber, L., Ivanov, D., Krieger, S.N., Streicher, M.N., Mildner, T., Poser, B.A., Möller, H.E., Turner, R., 2014. Slab-selective, BOLD-corrected VASO at 7 tesla provides measures of cerebral blood volume reactivity with high signal-to-noise ratio. Magn. Reson. Med. 72, 137–148. https://doi.org/10.1002/mrm.24916

## Citation (I used this batch script in these papers)
- Oliveira, Í.A.F., van der Zwaag, W., Raimondo, L., Dumoulin, S.O., Siero, J.C.W., 2021. Comparing hand movement rate dependence of cerebral blood volume and BOLD responses at 7T. Neuroimage 226, 117623. https://doi.org/10.1016/j.neuroimage.2020.117623
- Oliveira, Í.A.F., Cai, Y., Hofstetter, S., Siero, J.C.W., van der Zwaag, W., Dumoulin, S.O., 2022. Comparing BOLD and VASO-CBV population receptive field estimates in human visual cortex. Neuroimage 248, 118868. https://doi.org/10.1016/j.neuroimage.2021.118868

## Dependencies

- Matlab and SPM12

## How to use

1.) Here I use a fixed folder/filename format, organized as it follows:

 - project -> participants(subs) -> funct & anatomical data(T123DEPI)

```matlab
mkdir Project1
cd Project1

mkdir sub1
cd sub1

mkdir funct
mkdir T123EPI
```
![Format](https://github.com/icaroafoliveira/vaso_preprocesing_scripts/blob/main/assets/step1.jpg?raw=true)

2.) Move the VASO and BOLD data to the funct directory

![VASO & BOLD directory](https://github.com/icaroafoliveira/vaso_preprocesing_scripts/blob/main/assets/step2.jpg?raw=true)

3.) type **PAR_VASO** and select the project folder 
```matlab
PAR_VASO
```
![Select project folder](https://github.com/icaroafoliveira/vaso_preprocesing_scripts/blob/main/assets/step3.jpg?raw=true)

4.) type **par_VASO** to check all the participants and folders that were stored. The example shows only one participant, but you can add as many as you wish.
Mind that you need to add both *funct* and *T123DEPI* folders.

```matlab
par_VASO

         SPM_path: 'C:\spm12\spm12'
              root: 'D:\scripts\data_test'
             nsubs: 1
          subjects: {'sub1'}
      structfolder: 'T123DEPI'
        confilters: 'funct'
         nonnulled: 'BOLD'
            nulled: 'VASO'
          pureVASO: 'VASOp'
    estimate_TRIAL: 1
         structdir: {'D:\scripts\data_test\sub1\T123DEPI'}
           condirs: {'D:\scripts\data_test\sub1\funct'}

```

5.) Type **MoCo** to perform the motion correction on your group of participants
- The output is two 4D nifit data **rBOLD.nii** and **rVASO.nii**

6.) Type **BoCo** to perform the bold correction on your group of participants
- The output is a 4D nifti data **VASOp.nii**

